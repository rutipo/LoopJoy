class Item < ActiveRecord::Base
  after_save :set_api_initialization

  belongs_to :user
  attr_accessible :desc, :display_text, :name, :options, :price, :sku, :item_type, :image

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }


  def set_api_initialization
	@developer = User.find(self.user_id)
	@items = @developer.items
	$redis.set(@developer.api_key.to_s, {merchantName: @developer.merchant_name, items: @items})
  end

end
