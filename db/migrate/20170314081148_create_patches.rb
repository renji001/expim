class CreatePatches < ActiveRecord::Migration[5.0]
  def change
    create_table :patches do |t|
      t.string :patch_no
      t.integer :orders_count
      t.string :trans_no
      t.float :total_weight
      t.integer :package_count
      t.float :goods_count
      t.datetime :import_time
      t.datetime :print_cus_time
      t.datetime :print_cus2_time
      t.datetime :print_ciq_time
      t.datetime :print_ciq2_time


      t.timestamps
    end
  end
end
