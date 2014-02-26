class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
    	t.references :users
    	t.string :issue_description
    	t.string :issue_area
    	t.integer :issue_area_code, limit: 6
    	t.boolean :issue_status
      t.timestamps
    end
  end
end
