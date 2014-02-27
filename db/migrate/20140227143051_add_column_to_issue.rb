class AddColumnToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :project_est_cost, :decimal, :precision => 15, :scale => 2, :default => 0.0

    remove_column :fiscal_stats, :opening_blnc
    remove_column :fiscal_stats, :closing_blnc
  end
end