module Api
  class BaseController < ApplicationController
    protect_from_forgery
    after_filter :set_csrf_cookie_for_ng

    private
      def authenticate_user!
        unauthorized! unless current_user
      end

      def unauthorized!
        head :unauthorized
      end

      def current_user
        @current_user
      end

      def set_current_user
        Rails.logger.info "INFO ---- #{request.headers['Authorization']}"
        token = request.headers['Authorization'].to_s.split(' ').last
        return unless token
        Rails.logger.info "INFO ---- #{token}"

        payload = Token.new(token)

        @current_user = User.find(payload.user_id) if payload.valid?
      end

    protected
      def set_csrf_cookie_for_ng
        cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
      end

      def verified_request?
        super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
      end
  end
end
