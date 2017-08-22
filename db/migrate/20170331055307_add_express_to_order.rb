class AddExpressToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :realName, :string
    add_column :orders, :realPhone, :string
    add_column :orders, :consigneeAdress, :string
  end
end

