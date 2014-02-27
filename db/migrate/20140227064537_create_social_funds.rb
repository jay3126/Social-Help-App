class CreateSocialFunds < ActiveRecord::Migration
  def change
    create_table :social_funds do |t|
    	t.integer :fiscal_year, limit: 4
    	t.decimal :total_kitty_fund, :precision => 15, :scale => 2, :default => 0
    	t.decimal :fund_used, :precision => 15, :scale => 2, :default => 0
    	t.decimal :fund_remains, :precision => 15, :scale => 2, :default => 0
      t.timestamps
    end
  end
end
