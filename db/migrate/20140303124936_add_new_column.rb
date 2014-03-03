class AddNewColumn < ActiveRecord::Migration
  def change
  	add_column :issues, :issue_title, :string
  end
end