class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.date :exp_date
      t.string :category
      t.integer :quantity
      t.text :comment
      t.references :fridge, null: false, foreign_key: true
      t.string :unit

      t.timestamps
    end
  end
end
