module Api
  class AuthController < Api::BaseController
    def render_data(data, status)
      render json: data, status: status, callback: params[:callback]
    end

    def render_error(message, status = :unprocessable_entity)
      render_data({ error: message }, status)
    end

    def render_success(data, status = :ok)
      if data.is_a? String
        render_data({ message: data }, status)
      else
        render_data(data, status)
      end
    end

    def authenticate
      @oauth = "Oauth::#{params['provider'].titleize}".constantize.new(params)
      if @oauth.authorized?
        @user = User.from_auth(@oauth.formatted_user_data, current_user)
        if @user
          render_success(token: Token.encode(@user.id.to_s), id: @user.id)
        else
          render_error "This #{params[:provider]} account is used already"
        end
      else
        render_error("There was an error with #{params['provider']}. please try again.")
      end
    end
  end
end
