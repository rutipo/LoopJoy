class Developer < ActiveRecord::Base
	has_many :items
	before_save :set_api_key

	def set_api_key
		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
		string  =  (0..18).map{ o[rand(o.length)]  }.join;
		self[:apiKey] = string
	end

end
