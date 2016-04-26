class AddYearToFace < ActiveRecord::Migration
  def change
    add_column :faces, :year, :integer
  end
end
