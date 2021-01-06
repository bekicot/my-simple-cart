module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_api_user!

      def index
        invoices = current_api_user.invoices.includes(orders: [:store, :courier, order_items: {product_variant: [:product, {product_variant_details: :variant_option}]}])
        render status: 200, json: invoices
      end

      def checkout
        # [{store_id: 1, items: [{product_variant_id: 2, price: 1000, quantity: 10, discount: 10}, {product_variant_id: 3, price: 1000, quantity: 1, discount: 0}], courier: {id: 1, price: 10000}}]
        success, error_message = Order.checkout(current_api_user.id, order_params[:checkout])
        if success
          render status: 200, json: {success: true, message: 'Success'}
        else
          render status: 400, json: {status: false, message: 'Failed', error: error_message}
        end
      end

      private

      def order_params
        params.permit(:order, checkout: [:store_id, items: [:product_variant_id, :quantity, :notes], courier: [:id, :price]])
      end
      
    end
  end
end

