class RenameIssuesField < ActiveRecord::Migration
  def change
  	rename_column :issues, :users_id, :user_id
  end
end
