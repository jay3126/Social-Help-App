class AddFieldsToProjectReoprt < ActiveRecord::Migration
  def change
  	add_column :project_reports, :fund_release, :boolean, default: false
  end
end
