class CreateInvoicePics < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_pics do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
