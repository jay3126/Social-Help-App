class AddColumnToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :is_approved, :boolean, default: false
  end
end