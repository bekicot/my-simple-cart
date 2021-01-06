module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController

      private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation,:name)
      end

      def render_create_success
        render json: {status: 'success', user: resource_data }
      end

    end
  end
end