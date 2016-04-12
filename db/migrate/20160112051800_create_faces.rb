class CreateFaces < ActiveRecord::Migration
  def change
    create_table :faces do |t|
      t.string :file_1
      t.string :file_2

      t.timestamps null: false
    end
  end
end
