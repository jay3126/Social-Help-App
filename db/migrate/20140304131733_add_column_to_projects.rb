class AddColumnToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :issue_id, :integer
    add_column :projects, :closed_on, :date
    add_column :projects, :approved_on, :date

    add_column :issues, :closed_by, :integer
    add_column :issues, :rejected_by, :integer
    add_column :issues, :rejected_on, :date
    add_column :issues, :closed_on, :date
  end
end