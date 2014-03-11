class AddRemarksToProjectReport < ActiveRecord::Migration
  def change
  	add_column :project_reports, :remarks, :string
  	add_column :project_report_logs, :project_report_id, :integer
  end
end
