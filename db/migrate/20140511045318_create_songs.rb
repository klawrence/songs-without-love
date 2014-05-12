class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :artist_id
      t.string :title
      t.string :slug
      t.text :lyrics
      t.integer :peak_chart_position
      t.string :weeks_on_chart
      t.date :first_charted_on
      t.boolean :reissue

      t.timestamps
    end

    add_index :songs, :title
    add_index :songs, :artist_id
    add_index :songs, :first_charted_on
    add_index :songs, :slug, unique: true
  end
end
