class SongCrawler

  def initialize site
    @agent = Mechanize.new
    @site = site
  end

  def crawl artists_index
    log "Crawling #{@site}#{artists_index}"

    artist_pages = crawl_index_pages artists_index
    artist_pages.each do |url|
      crawl_artist_page url
    end
  end

  def crawl_index_pages index_page
    page = @agent.get index_page, [], @site
    links = page.links.map(&:href).select {|href| /b\/artists\/[0-9a-z]/ =~ href}
    log "Found #{links.count} index pages"

    fetch_artist_pages links
  end

  def fetch_artist_pages links
    artist_pages = []

    links.each do |link|
      page = @agent.get link, [], @site
      artist_pages += page.links.map(&:href).select { |href| /\/a\// =~ href }
    end

    log "Found #{artist_pages.count} artists"
    artist_pages
  end

  def crawl_artist_page artist_url
    log artist_url

    page = @agent.get artist_url, [], @site
    artist = create_artist page
    songs = create_songs artist, page

    log "#{artist}: #{songs.count} songs"
  end

  def create_songs artist, page
    songs = []

    rows = page.search 'table:first-of-type tr'
    rows.each do |row|
      cells = row.search 'td'
      if cells.count == 6
        songs << song = artist.songs.build
        song.title = cells[1].text
        song.first_charted_on = date_from cells[2].text
        song.peak_chart_position = cells[3].text.to_i
        song.weeks_on_chart = cells[5].text.to_i
        song.save
        # TODO errors?
      end
    end

    # TODO reject re-issues? Or maybe just flag them?

    songs
  end

  def date_from text
    Date.strptime text, '%d/%m/%Y'
  end

  def create_artist page
    # Create or find?
    # How do I know if I already have the artist? What if they have the same name?

    artist = Artist.new
    artist.name = page.search('.title h1').text
    artist.save
    # TODO errors?

    artist
  end

  def log message
    Rails.logger.info message
    puts message
  end
end
