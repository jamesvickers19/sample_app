class Micropost < ActiveRecord::Base

  belongs_to :user

  # MicropostEncouragement's
  has_many :encouragement_relationships, class_name: "PostEncouragement",
                                         foreign_key: "encouraged_id",
                                         dependent: :destroy

  has_many :encouragers, through: :encouragement_relationships
                         #, source: :encourager [not required since its the singular of 'encouragers'
                         #                       and matches up to :encourager in PostEncouragement
  ###################################################################################
  
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private

  # Validates the size of an uploaded picture
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
  
end
