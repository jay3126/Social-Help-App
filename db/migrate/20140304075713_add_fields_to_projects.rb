class AddFieldsToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :proposer_id, :integer
  	change_column :projects, :user_id, :integer
  	change_column :issues, :issue_status, :string
  end
end
