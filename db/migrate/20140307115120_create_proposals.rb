class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
    	t.decimal :proposed_cost, :precision => 15, :scale => 2
    	t.integer :proposed_duration
    	t.integer :user_id
    	t.integer :issue_id
    	t.string :desc
    	t.boolean :accepted, :default => false

      t.timestamps
    end

    remove_column :users, :category, :string
  end
end
