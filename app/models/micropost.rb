# This code defines the Micropost class, which inherits from ApplicationRecord,
# which in turn inherits from ActiveRecord::Base.
# The Micropost class has a single association, which is defined by the belongs_to method.
# The belongs_to method takes a symbol as an argument,
# which represents the name of the model that the Micropost class belongs to.
class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    return unless picture.size > 5.megabytes

    errors.add(:picture, "should be less than 5MB")
  end
end
