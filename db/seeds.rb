# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ngos = []
ngos << {name: "Help age India", year_established: 1978,website_address: "www.helpageindia.org",
	about: "HelpAge India is secular, not-for-profit organization registered under the Societies' Registration Act of 1860. We were set up in 1978, and since then have been raising resources to protect the rights of India's elderly and provide relief to them through various interventions.We voice the needs of India's 100 million (current estimate) grey population, and directly impact the lives of lakhs of elders through our services every year. We advocate with national & local government to bring about policy that is beneficial to the elderly. We make society aware of the concerns of the aged and promote better understanding of ageing issues. We help the elderly become aware of their own rights so that they get their due and are able to play an active role in society.",
	address: "C-14 Qutab Institutional Area",
	city: "New Delhi",
	state: "Delhi",
	phone_number: 41688955,
	pin_code: 110016,
	country: "India",
	service_type: "Elderly"
}

ngos << {name: "Smile Foundation", year_established: 2002,website_address: "smilefoundationindia.org",
	about: "Inspired by Senge's philosophy, a group of young corporate professionals came together in 2002 to set up Smile Foundation to work with grassroots initiatives for effecting positive changes in the lives of underprivileged children, their families and communities.",
	address: "V-11, Level - 1, Green Park Extension",
	city: "New Delhi",
	state: "Delhi",
	phone_number: 43123700,
	fax_number: 1141354454,
	pin_code: 110016,
	country: "India",
	service_type: "Children"
}

ngos << {name: "Goonj limited", year_established: 1999,website_address: "www.goonj.org",
	about: "GOONJ is considered one of the leading social enterprises in India, the largest non monetary resource agency and people also call it one of the largest civic participation movement!!",
	address: "GOONJ.. J-93, Sarita Vihar",
	city: "New Delhi",
	state: "Delhi",
	phone_number: 26972351,
	pin_code: 110076,
	country: "India",
	service_type: "Education"
}

ngos << {name: "CRY", year_established: 1979,website_address: "www.cry.org",
	about: "CRY India is a NGO, Independent and social service organization working for child rights. CRY stands for Child rights and you, the organization was set up in 1979 by Rippan kapoor. It is one of the top charity in India which aims to flight for better child education, food and health. CRY is headquartered in Mumbai and has branch offices in Bangalore, Chennai, Delhi and Kolkata.",
	address: "CRY - Child Rights and You, 189/A Anand Estate, Sane Guruji Marg",
	city: "Mumbai",
	state: "Maharashtra",
	phone_number: 2223063647,
	fax_number: 2223080726,
	pin_code: 400011,
	country: "India",
	service_type: "Children"
}

ngos << {name: "Give India", year_established: 1999, website_address: "www.giveindia.org",
	about: "We connect individuals with 200+ grassroot NGOs working for the poor in India. All organizations have been pre-screened by us so that you can trust that they will use your donation correctly. By helping you donate to these charities online, we ensure that your giving is efficient and impactful. We guarantee that 90% of your donation reaches the NGO you chose.",
	address: "GiveIndia 3rd Floor, West Khetwadi Municipal School, Khetwadi lane No.5",
	city: "Mumbai",
	state: "Maharashtra",
	phone_number: 2223894944,
	pin_code: 400004,
	country: "India",
	service_type: "Employment"
}

ngos << {name: "Nanhi Kali", year_established: 1996, website_address: "www.nanhikali.org",
	about: "Project Nanhi Kali was initiated in 1996 by the K. C. Mahindra Education Trust (KCMET) with the aim of providing primary education to underprivileged girl children in India.",
	address: "K. C. Mahindra Education Trust Cecil Court Near Regal Cinema Mahakavi Bhushan Marg",
	city: "Mumbai",
	state: "Maharashtra",
	phone_number: 2222895500,
	fax_number:  2222852441,
	pin_code: 400001,
	country: "India",
	service_type: "Women"
}

ngos.each_with_index do |n,i|
	user = User.new
	user.role = "NGO"
	user.email = "ngo#{i > 0 ? i : ''}" + "@help.com"
	user.password = 12345
	user.password_confirmation = 12345
	n.each do |k,v|
		user.send("#{k}=",v)
	end
	user.save
	file_name = "#{Rails.root}/app/assets/images/" + n[:name].downcase.split(" ").join("_") + ".jpg"
	image = File.open(file_name)
	logo = Logo.new
	logo.user_id = user.id
	logo.logo = image
	logo.save
	image.close
end