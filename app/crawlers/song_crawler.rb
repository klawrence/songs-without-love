class SongCrawler
  attr_reader :agent

  def initialize
    @agent = Mechanize.new
  end

  def crawl index_page
    crawl_artist_page index_page
  end

  def crawl_artist_page artist_url
    log artist_url

    page = agent.get artist_url
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
        song.peak_chart_position = cells[1].text.to_i
        song.weeks_on_chart = cells[1].text.to_i
        song.save
        # TODO errors?
      end
    end

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
