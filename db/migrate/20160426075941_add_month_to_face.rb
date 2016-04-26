class AddMonthToFace < ActiveRecord::Migration
  def change
    add_column :faces, :month, :string
  end
end
