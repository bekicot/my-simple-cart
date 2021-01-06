module Api
  module V1
    class ProductsController < ApplicationController

      def index
        query = params[:q].presence || "*"
        products = ProductSearch.new(query: query, options: search_params).search
        render json: products
      end

      private  def search_params
        params.permit :q, :store_id, :store_name, :sort_attribute, :sort_order
      end

    end
  end
end

