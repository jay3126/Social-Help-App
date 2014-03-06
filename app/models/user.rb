class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :fiscal_stats
  has_and_belongs_to_many :issues
  has_one :logo
  has_many :projects
  has_many :project_reports

  validates :role, :name, :address, :city, :pin_code, :state, :country, :mobile_number, :phone_number, :fax_number, presence: true
  validate :specific_fields

  def specific_fields
  	if self.role.present?
  		case self.role
  		when "NGO"
  			unless self.service_type.present?
  				self.errors.add :service_type, "must be present"
  			end
  			unless self.owner.present?
  				self.errors.add :owner, "must be present"
  			end
  			unless self.year_established.present?
  				self.errors.add :year_established, "must be present"
  			end
  		when "Corporate"
  			unless self.company_group.present?
  				self.errors.add :company_group, "must be present"
  			end  			
  			unless self.tan_number.present?
  				self.errors.add :tan_number, "must be present"
  			end  			
  			unless self.no_of_employees.present?
  				self.errors.add :no_of_employees, "must be present"
  			end
  			unless self.owner.present?
  				self.errors.add :owner, "must be present"
  			end
  			unless self.year_established.present?
  				self.errors.add :year_established, "must be present"
  			end  			
  		when "Socialist"
  			unless self.age.present?
  				self.errors.add :age, "must be present"
  			end  			
  			unless self.gender.present?
  				self.errors.add :gender, "must be present"
  			end  			
  			unless self.adhaar_number.present?
  				self.errors.add :adhaar_number, "must be present"
  			end  			
  			unless self.voter_id.present?
  				self.errors.add :voter_id, "must be present"
  			end  			
  			unless self.nationality.present?
  				self.errors.add :nationality, "must be present"
  			end  			
  			unless self.pan_number.present?
  				self.errors.add :pan_number, "must be present"
  			end
			end			
  	end
  end

  def self.fetch_user_names(user_id)
    user = User.where(id: user_id).first
    user.present? ? user.name : ""
  end

  def corporate?
    self.role.to_s.downcase == "corporate"
  end

  def socialist?
    self.role.to_s.downcase == "socialist"
  end

  def analyst?
    self.role.to_s.downcase == "analyst"
  end

  def ngo?
    self.role.to_s.downcase == "ngo"
  end

  def inspector?
    self.role.to_s.downcase == "inspector"
  end

end