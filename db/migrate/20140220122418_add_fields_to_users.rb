class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :address, :string
  	add_column :users, :pin_code, :integer, limit: 6
  	add_column :users, :city, :string
  	add_column :users, :state, :string
  	add_column :users, :country, :string

  	add_column :users, :mobile_number, :string
  	add_column :users, :phone_number, :string
  	add_column :users, :fax_number, :string

  	add_column :users, :owner, :string
  	add_column :users, :service_type, :string
  	add_column :users, :company_group, :string
  	add_column :users, :pan_number, :string
  	add_column :users, :tan_number, :string
  	add_column :users, :year_established, :integer, limit: 4
  	add_column :users, :no_of_employees, :integer

  	add_column :users, :age, :integer, limit: 3
  	add_column :users, :gender, :string, limit: 6
  	add_column :users, :adhaar_number, :string
  	add_column :users, :voter_id, :string
  	add_column :users, :nationality, :string

  	add_column :users, :role, :string, limit: 15
  end
end
