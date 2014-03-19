# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Constants::ROLES.each do |role|
	user = User.new
	user.role = role
	user.email = role.downcase + "@help.com"
	user.password = 12345
	user.password_confirmation = 12345
	user.name = role
	user.address = role + " street"
	user.pin_code = 123456
	user.city = role + "city"
	user.state = role + "state"
	user.country = role + " country"
	user.mobile_number = 1234567890
	user.phone_number = 1234567890
	user.fax_number = 1234567890

	if role.downcase == "corporate"
		user.company_group = role + " company group"
		user.tan_number = "AAGGB6578J"
		user.no_of_employees = 2000
	end

	if role.downcase == "ngo"
		user.service_type = "Children"
	end

	if ["corporate","ngo"].include?(role.downcase)
		user.owner = role + " Owner"
		user.year_established = 1950
	end

	if ["socialist","donor"].include?(role.downcase)
		user.age = 30
		user.gender = "Male"
		user.adhaar_number = "AADHAR1234"
		user.voter_id = "EC12345"
		user.nationality = "Indian"
		user.pan_number = "PPGGB6578J"
	end
	user.save
end