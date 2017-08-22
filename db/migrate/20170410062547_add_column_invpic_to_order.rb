class AddColumnInvpicToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :inv_pic, :string
  end
end
