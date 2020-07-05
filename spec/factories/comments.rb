FactoryBot.define do
  factory :comment do
    body {'Nothing special'}
    user
    article
  end
end
