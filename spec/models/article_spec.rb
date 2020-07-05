require 'rails_helper'

RSpec.describe Article do
    describe "authentications" do
        it { is_expected.to have_many(:comments)}
    
        it { is_expected.to belong_to(:user)}
    
        describe "when deleting article" do
          let(:comment_count) { 1 }
          let(:article) { create(:article) }
          it 'should delete all comments' do
            create_list(:comment, comment_count, article: article)
            expect { article.destroy }.to change{ Comment.count }.by(-comment_count)
          end
        end
    end
    describe "validations" do
        context 'when trying to save empty fields' do
            it { is_expected.to validate_presence_of(:title)}
        end
            
        it { is_expected.to validate_length_of(:title).is_at_least(Article::MINIMUM_TITLE_LENGTH)}

        it { is_expected.to validate_length_of(:title).is_at_most(Article::MAXIMUM_TITLE_LENGTH)}
    end
end
