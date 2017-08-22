class AddRealTransformerToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :real_transformer, :string
  end
end
