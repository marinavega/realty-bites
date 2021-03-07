# frozen_string_literal: true

class CreateOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :owners do |t|
      t.integer :category, null: false
      t.string :name, null: false
      t.string :phone, unique: true
      t.string :email, unique: true

      t.timestamps
    end
  end
end
