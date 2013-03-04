class Item < ActiveRecord::Base
  after_save :set_api_initialization

  belongs_to :developer
  attr_accessible :desc, :display_text, :name, :options, :price, :sku, :item_type, :image, :developer_id


  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }


  def set_api_initialization
	@developer = Developer.find(self.developer_id)
	@items = @developer.items
	$redis.set(@developer.api_key.to_s, {merchantName: @developer.merchant_name, items: @items})
  end

  def as_json(options={})
  	h = super(options)
  	#Change this to use config env host to return the correct url
  	h[:image_url] = "http://" + ::Lj::Application.config.env_vars.host + image.url
    h[:price] = price.to_i
  	h
  end

end
