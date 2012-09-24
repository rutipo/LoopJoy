class Developer < ActiveRecord::Base
	has_many :items

	def apiKey=(apiKey)
		unless self.apiKey?
			o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
			string  =  (0..18).map{ o[rand(o.length)]  }.join;
			super string
		end
	end

end
