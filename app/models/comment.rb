class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :comment
  validates :commenter, :body, presence: true
end
