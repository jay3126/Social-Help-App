class ChangeColumnTypeInProject < ActiveRecord::Migration
  def change
  	change_column :projects, :project_est_cost, :decimal, :precision => 15, :scale => 2, :default => 0.0
  	change_column :projects, :project_actual_cost, :decimal, :precision => 15, :scale => 2, :default => 0.0
  end
end