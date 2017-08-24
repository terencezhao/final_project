# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  category_id :integer
#  brand_id    :integer
#  price       :float
#  image_url   :string
#  details     :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
    has_many :owns, :dependent => :destroy
    has_many :wants, :dependent => :destroy
    has_many :reviews, :dependent => :destroy
    belongs_to :brand
    belongs_to :category
    
    validates :brand, :presence => true
    validates :category, :presence => true
end
