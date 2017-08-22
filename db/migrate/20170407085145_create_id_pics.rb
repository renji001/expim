class CreateIdPics < ActiveRecord::Migration[5.0]
  def change
    create_table :id_pics do |t|
      t.string :pic_name
      t.string :url
      t.string :path

      t.timestamps
    end
  end
end
