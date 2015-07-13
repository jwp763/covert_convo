class Interest < ActiveRecord::Base
  belongs_to :category
  
  has_many :user_interests
  has_many :users, through: :user_interests
end
