FactoryBot.define do
    factory :user do
        sequence :email do |n| "testing#{n}@gmail.com" end
        name {'John'}
        password {'123456'}
        password_confirmation {'123456'}
    end
end