require 'rails_helper'

RSpec.describe Comment do
    describe "authentications" do
        it { is_expected.to belong_to(:article)}
    
        it { is_expected.to belong_to(:user)}
      end
      describe "validations" do
        context 'when trying to save empty fields' do
          it { is_expected.to validate_presence_of(:body)}
        end
            
        it { is_expected.to validate_length_of(:body).is_at_least(Comment::MINIMUM_BODY_LENGTH)}
    
        it { is_expected.to validate_length_of(:body).is_at_most(Comment::MAXIMUM_BODY_LENGTH)}
      end
end
