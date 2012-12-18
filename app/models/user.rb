class User < ActiveRecord::Base
	has_many :items
	after_create :set_api_key_and_role


	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  	# Include default devise modules. Others available are:
  	# :token_authenticatable, :confirmable,
  	# :lockable, :timeoutable and :omniauthable
  
  	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me,
		:name, :merchant_name, :role, :api_key

	def set_api_key_and_role
		self.role = "user"

		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
		string  =  (0..18).map{ o[rand(o.length)]  }.join;
		self.api_key = string
		self.save
	end



end
