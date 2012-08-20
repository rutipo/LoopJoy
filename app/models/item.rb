class Item < ActiveRecord::Base
  belongs_to :developer
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  after_save :set_image_url

  def set_image_url
  	if(self.image_url.blank?)
  	image_path = "http://50.16.220.58#{self.image.url}"
  	self.update_attributes(:image_url => image_path ||= "none")
  	end
  end

end
