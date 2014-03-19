class NewFieldInProposals < ActiveRecord::Migration
  def change
  	remove_column :proposals, :accepted, :boolean
  	add_column :proposals, :status, :string
  end
end
