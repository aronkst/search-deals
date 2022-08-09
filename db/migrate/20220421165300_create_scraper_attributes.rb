class CreateScraperAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :scraper_attributes do |t|
      t.references :scraper, null: false, foreign_key: true
      t.text :value, null: false
      t.text :tags, null: false
      t.string :html, null: true
      t.text :replace, null: true

      t.timestamps
    end
  end
end
