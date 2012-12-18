class User < ActiveRecord::Base
	has_many :items
	after_initialize :setDefaultUserRole
	after_create :setApiKey


	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  	# Include default devise modules. Others available are:
  	# :token_authenticatable, :confirmable,
  	# :lockable, :timeoutable and :omniauthable
  
  	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me,
		:name, :merchant_name, :role, :api_key


	def setDefaultUserRole
		self.role = "user"
	end

	def setApiKey
		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
		string  =  (0..18).map{ o[rand(o.length)]  }.join;
		self.api_key = string
	end

	def api_key=(api_key)
		unless self.api_key?
			o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
			string  =  (0..18).map{ o[rand(o.length)]  }.join;
			super string
		end
	end

end
