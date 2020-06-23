module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user    
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    def logged_in?
        current_user.present?
    end

    def logged_out?
        current_user.blank?
    end

    def logged_in_notice
        flash[:alert] = 'Already logged in'
        redirect_to root_path and return
    end
end
