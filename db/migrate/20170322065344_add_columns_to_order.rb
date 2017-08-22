class AddColumnsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :good_serial_num, :integer
    add_column :orders, :good_no, :string
    add_column :orders, :good_name, :string
    add_column :orders, :good_type, :string
    add_column :orders, :declare_price, :float
    add_column :orders, :declare_total, :float
    add_column :orders, :declare_num, :float
    add_column :orders, :declare_unit, :string
    add_column :orders, :goods_weight, :float
  end
end
