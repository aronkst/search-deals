class AddUniqueIndexAtScraperAttribute < ActiveRecord::Migration[7.0]
  def change
    add_index :scraper_attributes, %i[value scraper_id], unique: true
  end
end
