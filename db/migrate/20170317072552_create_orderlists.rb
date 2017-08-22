class CreateOrderlists < ActiveRecord::Migration[5.0]
  def change
    create_table :orderlists do |t|
      t.string :good_serial_num
      t.string :good_no
      t.string :good_name
      t.string :good_type
      t.string :product_country
      t.string :trade_currency
      t.float :declare_price
      t.float :declare_total
      t.float :declare_num
      t.string :declare_unit
      t.float :goods_weight

      t.timestamps
    end
  end
end
