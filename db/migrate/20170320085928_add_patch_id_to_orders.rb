class AddPatchIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :patch_id, :integer
  end
end
