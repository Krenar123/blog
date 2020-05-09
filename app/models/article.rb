class Article < ApplicationRecord
    # validation of what columns ( constraint in sql )
    validates :title, presence: true, length: {minimum: 5, maximum: 40}
    
end
