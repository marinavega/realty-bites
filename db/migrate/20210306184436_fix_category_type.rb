class FixCategoryType < ActiveRecord::Migration[6.1]
  def change
    change_column :owners, :category, :string
    change_column :houses, :category, :string
  end
end
