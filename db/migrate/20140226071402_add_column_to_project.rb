class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :verified, :boolean, default: false
    add_column :projects, :project_status, :string
  end
end