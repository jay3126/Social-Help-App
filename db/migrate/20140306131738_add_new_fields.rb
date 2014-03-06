class AddNewFields < ActiveRecord::Migration
  def change
  	add_column :users, :category, :string
  	add_column :issues, :category, :string
    add_column :fiscal_stats, :pref_cat, :string
  	add_column :social_funds, :fund_for_children, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_disabled, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_education, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_elderly, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_employment, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_environment, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_health, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_women, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_youth, :decimal, :precision => 15, :scale => 2, :default => 0
  	add_column :social_funds, :fund_for_others, :decimal, :precision => 15, :scale => 2, :default => 0
  end
end
