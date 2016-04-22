class PostEncouragement < ActiveRecord::Base

  belongs_to :encourager, class_name: "User"
  belongs_to :encouraged, class_name: "Micropost"

  validates :encourager_id, presence: true
  validates :encouraged_id, presence: true  
  
end
