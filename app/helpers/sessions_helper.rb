module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user    
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id]) 
        end
    end
    def logged_in?
        current_user.present?
    end

    def logged_out?
        current_user.blank?
    end

    def log_out
        session.clear
        @current_user = nil
    end

    def logged_in_notice(alert = 'danger', message = 'Must be logged in', path = root_path)
        flash[alert] = message
        redirect_to path and return
    end

    def equal_users?(other)
        current_user == other
    end
end
