require 'rails_helper'

RSpec.describe User do
  context "when saving" do
    it "transform email to lower case" do
      user = create(:user,email:'TEST@TEST.com')
      expect(user.email).to eq('test@test.com')
    end
  end
  describe "authentications" do
    it { is_expected.to have_secure_password}
    
    it { is_expected.to have_many(:comments)}

    it { is_expected.to have_many(:articles)}

    describe "when deleting user" do
      let(:comment_count) { 1 }
      let(:article_count) { 1 }
      let(:user) { create(:user) }
      it 'should delete all comments' do
        create_list(:comment, comment_count, user: user)
        expect { user.destroy }.to change{ Comment.count }.by(-comment_count)
      end

      it 'should delete all articles' do
        create_list(:article, article_count, user: user)
        expect { user.destroy }.to change{ Article.count }.by(-article_count)
      end
    end
  end
  describe "validations" do
    context 'when trying to save empty fields' do
      it { is_expected.to validate_presence_of(:name)}
      
      it { is_expected.to validate_presence_of(:email)}
  
      it { is_expected.to validate_presence_of(:password)}
    end
        
    it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH)}

    it { is_expected.to validate_length_of(:name).is_at_most(User::MAXIMUM_NAME_LENGTH)}

    it { is_expected.to validate_length_of(:email).is_at_most(User::MAXIMUM_EMAIL_LENGTH)}
    
    context 'when email is the same' do
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
