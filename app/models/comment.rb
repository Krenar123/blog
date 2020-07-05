class Comment < ApplicationRecord
  MINIMUM_BODY_LENGTH = 10
  MAXIMUM_BODY_LENGTH = 150
  belongs_to :article
  belongs_to :user
  validates :body, presence: true,  length: {minimum: MINIMUM_BODY_LENGTH, maximum: MAXIMUM_BODY_LENGTH}
end
