class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :project_type
      t.string :area
      t.integer :project_est_cost
      t.integer :project_actual_cost
      t.date :est_start_date
      t.date :actual_start_date
      t.date :est_completion_date
      t.date :actual_completion_date
      t.integer :assigned_to
      t.integer :assigned_by
      t.integer :verified_by
      t.integer :closed_by
      t.string :project_duration

      t.timestamps
    end
  end
end
