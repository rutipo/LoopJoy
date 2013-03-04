class User < ActiveRecord::Base
	has_one :developer

	after_save :set_role
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  	# Include default devise modules. Others available are:
  	# :token_authenticatable, :confirmable,
  	# :lockable, :timeoutable and :omniauthable
  
  	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me,
		:name, :merchant_name, :role, :api_key

	def set_role
		self.role = "user"
	end


end
