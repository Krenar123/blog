class Article < ApplicationRecord
    # validation of what columns ( constraint in sql )
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :title, presence: true, length: {minimum: 5, maximum: 40}
end
