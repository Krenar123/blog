require 'rails_helper'

RSpec.describe "ArticleInteraction" do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    before do
        driven_by :rack_test

        log_in(user)
        # visit article_path(article)
    end

    describe 'Creating an article' do
        it 'creates and shows newly created article' do
            title = 'Create new system'
            body = 'This is body'

            click_on('New Article')
    
            within('form') do
                fill_in 'Title', with: title
                fill_in 'Body', with: body
    
                click_on 'Create Article'
            end

            expect(page).to have_content(title)
            expect(page).to have_content(body)
        end
    end

    describe 'Editing an article' do
        it 'edits and shows the article' do
            title = "New title"
            body = "New body"
            visit article_path(article)

            click_on 'Edit'

            within('form') do
                fill_in 'Title',with: title
                fill_in 'Body',with: body

                click_on 'Save Article'
            end

            expect(page).to have_content(title)
            expect(page).to have_content(body)
        end
    end

    describe 'Deleting an article' do
        it 'deletes the article and redirect to root' do
            visit article_path(article)

            click_on 'Delete'

            expect(page).to have_content('I am going to buy that Tesla car.')
        end
    end

    describe 'Creating new article comments' do
        it 'creates an article comment' do
            comment =  'new comment'
            visit article_path(article)

            click_on 'Comment'

            within('form') do
                fill_in 'comment_body', with: comment

                click_on 'Comment'
            end

            expect(page).to have_content(comment)
        end
    end

    describe 'Going back to article index page' do
        it 'should go back to root path' do
            visit article_path(article)

            click_on 'Back'

            expect(page).to have_content('I am going to buy that Tesla car.')
        end
    end
end