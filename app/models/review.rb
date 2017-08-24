# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  quality    :integer
#  value      :integer
#  style      :integer
#  utility    :integer
#  enjoyment  :integer
#  recommend  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ApplicationRecord
    belongs_to :product
    belongs_to :user
    
    validates :user_id, :presence => true
    validates :product_id, :presence => true
end
