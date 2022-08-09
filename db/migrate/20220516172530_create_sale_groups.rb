class CreateSaleGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_groups do |t|
      t.references :scraper, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
