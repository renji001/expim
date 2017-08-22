class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :trans_no
      t.string :waybill
      t.string :local_port
      t.datetime :in_out_time
      t.string :ship_port
      t.string :conveyance_name
      t.string :conveyance_code
      t.string :conveyance_type
      t.string :declarer_name
      t.string :declarer_phone
      t.string :declarer_addr
      t.string :declarer_id
      t.string :declare_company_code
      t.string :declare_company_name
      t.string :trade_country
      t.integer :package_count
      t.integer :package_type
      t.string :declare_port
      t.string :shipper_name
      t.string :shipper_country
      t.string :shipper_city
      t.string :currency
      t.string :declare_type
      t.string :main_good
      t.string :real_name
      t.string :real_addr
      t.string :real_id


      t.timestamps
    end
  end
end
