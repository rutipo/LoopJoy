class Developer < ActiveRecord::Base
  belongs_to :user
  attr_accessible :api_key, :merchant_name, :user_id
  has_many :items

  after_create :set_api_key

	def set_api_key
		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
		string  =  (0..18).map{ o[rand(o.length)]  }.join;
		self.api_key = string
		self.save
	end

end
