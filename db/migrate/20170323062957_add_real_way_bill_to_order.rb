class AddRealWayBillToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :real_waybill, :string
  end
end
