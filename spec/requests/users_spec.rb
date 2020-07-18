require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "User sign up" do
    it "creates a User and redirects us to the User's page" do
      get users_signup_path
      expect(response).to render_template(:new)
      post_params = {
        params: {
          user: {
            name: 'Krenar',
            email: 'krenar@gmail.com',
            password: '12345678',
            password_confirmation: '12345678'
          }
        }       
      }
      post '/users',  post_params

      expect(session[:user_id]).not_to be_nil
      expect(response).to redirect_to(assigns(:user))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include('Krenar')
    end

    it "renders new when creating User with empty params" do
      get users_signup_path
      
      post_params = {
        params: {
          user: {
            name: '',
            email: '',
            password: '',
            password_confirmation: ''
          }
        }       
      }
      post '/users',  post_params

      expect(session[:user_id]).to be_nil
      expect(response).to render_template(:new)
    end
  end

  describe 'Editing an article' do
    context 'when the article user is the same as logged in User'do
      let(:user) { create(:user) }
      let(:article) { create(:article,user: user) }

      it 'can edit the article' do
        get '/login'

        expect(response).to have_http_status(:ok)

        post_params = {
          params: {
            ss: {
              email: user.email,
              password: user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!
        expect(flash[:success]).to eq "Sign in successful. Welcome #{user.name}"
      
        get "/articles/#{article.id}"

        expect(response).to have_http_status(:ok)

        get "/articles/#{article.id}/edit"
        expect(response).to have_http_status(:ok)

        patch_params = {
          params: {
            article: {
              title: article.title,
              body: "New Body"
            }
          }
        }

        patch "/articles/#{article.id}", patch_params

        expect(response).to have_http_status(:found)

        expect(response).to redirect_to(assigns(:article))

        follow_redirect!

        expect(response.body).to include(article.title)
      end
    end

    context 'when the article user is different from logged in User'do
      let(:user) { create(:user) }
      let(:login_user) { create(:user) }

      let(:article) { create(:article,user: user) }

      it 'can edit the article' do
        get '/login'

        post_params = {
          params: {
            ss: {
              email: login_user.email,
              password: login_user.password
            }
          }
        }

        post '/login', post_params

        get "/articles/#{article.id}/edit"

        expect(flash[:danger]).to eq "You have no permission"
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when no user is logged in' do
      let(:article) { create(:article) }
      
      it 'redirects to root path with flash danger'do
        get "/articles/#{article.id}/edit"
       
        expect(flash[:danger]).to eq "Must be logged in"
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'Deleting an article'do
    context 'when the articles user is the same as logged in user'do
      let(:user) { create(:user) }
      let(:article) { create(:article,user:user) }

      it 'can delete the article'do
        get '/login'

        post_params = {
          params: {
            ss: {
              email: login_user.email,
              password: login_user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!

        delete "/articles/#{article.id}"

        expect(response).to redirect_to(articles_path)
        # I should add to delete the article and expect success
      end

      context 'when articles user is different from logged in user'do
        
      end

      context 'when no user logged in' do
        
      end
    end
  end
end
