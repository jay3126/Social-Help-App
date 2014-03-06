class ProjectTables < ActiveRecord::Migration
  def change

  	create_table(:project_reports) do |t|
  		t.integer :project_id
  		t.integer :percent_done
  		t.integer :user_id
  		t.string :status, default: "pending"
  		t.timestamps
  	end

  	create_table(:project_report_logs) do |t|
  		t.integer :project_id
  		t.integer :user_id
  		t.string :action
  		t.string :desc
  		t.timestamps
  	end

  	create_table(:project_funds) do |t|
  		t.integer :project_id
  		t.integer :project_report_id
  		t.string :fund_status, default: "pending"
  		t.integer :allocate_by
  		t.decimal :fund_amount, precision: 15, scale: 2, default: 0
  		t.date :allocate_date
  		t.timestamps
  	end

  	create_table(:project_fund_logs) do |t|
  		t.integer :project_id
  		t.integer :user_id
  		t.decimal :fund_amount, precision: 15, scale: 2, default: 0
  		t.string :transc_type
  		t.string :category
  		t.timestamps
  	end


  end
end
