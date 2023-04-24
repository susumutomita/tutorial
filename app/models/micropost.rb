# This code defines the Micropost class, which inherits from ApplicationRecord,
# which in turn inherits from ActiveRecord::Base.
# The Micropost class has a single association, which is defined by the belongs_to method.
# The belongs_to method takes a symbol as an argument,
# which represents the name of the model that the Micropost class belongs to.
class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
