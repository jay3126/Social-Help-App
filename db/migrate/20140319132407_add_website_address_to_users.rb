class AddWebsiteAddressToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :website_address, :string
  	add_column :users, :about, :text
  end
end
