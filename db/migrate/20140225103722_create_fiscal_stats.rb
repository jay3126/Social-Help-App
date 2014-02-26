class CreateFiscalStats < ActiveRecord::Migration
  def change
    create_table :fiscal_stats do |t|
    	t.integer :fiscal_year, limit: 4
    	t.decimal :opening_blnc, :precision => 15, :scale => 2, :default => 0.0
    	t.decimal :closing_blnc, :precision => 15, :scale => 2, :default => 0.0
    	t.string :currency_type
    	t.decimal :total_revenue, :precision => 15, :scale => 2
    	t.decimal :net_profit, :precision => 15, :scale => 2
    	t.decimal :available_social_fund, :precision => 15, :scale => 2
    	t.integer :user_id
    	t.boolean :eligibility_status, :default => false

      t.timestamps
    end
  end
end