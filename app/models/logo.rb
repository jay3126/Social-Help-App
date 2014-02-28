class Logo < ActiveRecord::Base

	has_attached_file :logo,
										styles: { :medium => "300x300>", :thumb => "100x100>" },
										default_url: "/images/missing.jpg",
										path: ":rails_root/public/logos/:id/:style/:filename",
										url: "/logos/:id/:style/:filename"
	validates_attachment :logo, :presence => true,
  :content_type => { :content_type => /\Aimage\/.*\Z/ }

end