require 'rails_helper'

RSpec.describe User, type: :model do
  context "when saving" do
    it "transform email to lower case" do
      user = create(:user,email:'TEST@TEST.com')
      expect(user.email).to eq('test@test.com')
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name)}
    
    it { is_expected.to validate_presence_of(:email)}

    it { is_expected.to validate_presence_of(:password)}
        
    it { is_expected.to have_secure_password}
  
    it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH)}

    it { is_expected.to validate_length_of(:name).is_at_most(User::MAXIMUM_NAME_LENGTH)}

    it { is_expected.to validate_length_of(:email).is_at_most(User::MAXIMUM_EMAIL_LENGTH)}
    
    it { is_expected.to have_many(:articles) }
    
    context 'other validate' do
      subject { create(:user) }
      it {  is_expected.to validate_uniqueness_of(:email) }
    end

    context 'when using invalid email format' do
      it 'is invalid' do
        john  = build(:user, email: 'test@email')
        expect(john.valid?).to be false
      end
    end
  end
end
