class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :sale_group, null: false, foreign_key: true
      t.string :title
      t.float :value
      t.integer :porcentage
      t.string :image
      t.string :link

      t.timestamps
    end
  end
end
