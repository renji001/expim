class AddColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :consigneeProv, :string
    add_column :orders, :consigneeCity, :string
    add_column :orders, :consigneeTown, :string
    add_column :orders, :markDest, :string
    add_column :orders, :sortingSite, :string
    add_column :orders, :sortingCode, :string
    add_column :orders, :pkgCode, :string
  end
end
