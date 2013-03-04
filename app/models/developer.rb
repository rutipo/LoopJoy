class Developer < ActiveRecord::Base
  belongs_to :user
  attr_accessible :api_key, :merchant_name
  has_many :items
end
