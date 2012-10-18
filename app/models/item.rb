class Item < ActiveRecord::Base
  belongs_to :developer
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def as_json(options={})
  	h = super(options)
  	h[:image_url] = "http://loopjoy.com" + image.url
  	h[:item] = item.to_i
  	h
  end

end
