class AddReporttypeToFace < ActiveRecord::Migration
  def change
    add_column :faces, :reporttype, :string
  end
end
