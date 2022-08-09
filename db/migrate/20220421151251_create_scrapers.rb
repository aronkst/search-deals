class CreateScrapers < ActiveRecord::Migration[7.0]
  def change
    create_table :scrapers do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.integer :pages, null: false
      t.integer :value, null: false
      t.integer :porcentage, null: false
      t.text :html, null: false

      t.timestamps
    end
  end
end
