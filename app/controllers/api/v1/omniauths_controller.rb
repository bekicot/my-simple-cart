module Api
  module V1
    class OmniauthsController < ApplicationController

      def create
        user = User.from_social_provider(params[:provider], social_media_params)
        if user
          render json: {status: 'success', user: user}
        else
          render json: {status: 'failed'}
        end
      end

      private

      def social_media_params
        params.permit(:email, :name, :uid)
      end

    end
  end
end

