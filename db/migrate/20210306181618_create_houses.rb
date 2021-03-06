# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :houses do |t|
      t.integer :category, null: false
      t.integer :size, null: false
      t.integer :rooms, null: false
      t.integer :bathrooms, null: false
      t.integer :price, null: false
      t.string :address
      t.string :link, null: false, unique: true
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
