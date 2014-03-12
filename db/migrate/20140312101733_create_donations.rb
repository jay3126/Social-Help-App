class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    	t.references :user
    	t.decimal :amount, :precision => 15, :scale => 2, :default => 0
    	t.string :category
      t.timestamps
    end
  end
end
