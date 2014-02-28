class CreateLogo < ActiveRecord::Migration
  def change
    create_table :logos do |t|
    	t.references :user
    	t.attachment :logo
    end
  end
end
