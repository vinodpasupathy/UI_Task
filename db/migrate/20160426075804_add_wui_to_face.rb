class AddWuiToFace < ActiveRecord::Migration
  def change
    add_column :faces, :wui, :float
  end
end
