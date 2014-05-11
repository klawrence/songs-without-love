class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :cached_slug, :uniq

      t.timestamps
    end
  end
end
