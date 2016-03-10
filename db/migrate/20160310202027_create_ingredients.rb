class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :price

      t.timestamps null: false
    end
  end
end
