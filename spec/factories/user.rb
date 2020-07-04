FactoryBot.define do
    factory :user do
        email {'testing@gmail.com'}
        name {'John'}
        password {'123456'}
        password_confirmation {'123456'}
    end
end