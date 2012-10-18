class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :desc, :display_text, :name, :options, :price, :sku, :item_type, :image

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
