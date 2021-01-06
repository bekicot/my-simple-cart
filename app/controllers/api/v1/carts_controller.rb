module Api
  module V1
    class CartsController < ApplicationController
      
      before_action :authenticate_api_user!

      def index
        carts = current_api_user.carts.includes(:store, cart_items: [:product_variant => :product])
        render status: 200, json: carts
      end

      def add
        product_variant = ProductVariant.find(params[:product_variant_id])
        success, error_messages = Cart.add_product(current_api_user, product_variant, params[:cart][:quantity], params[:cart][:notes])
        if success
          render status: 200, json: {
            success: true, message: "#{product_variant.product.name} has been successfully added to your cart."
          }
        else
          render status: 400, json: {
            success: false, message: "Failed", errors: error_messages
          }
        end
      end

      def update
        cart_item = CartItem.find(params[:id])
        if params[:cart][:quantity].to_i == 0
          cart_item.delete_with_parent_if_no_child
          return render status: 200, json: {
            success: true, message: "product has been successfully removed to your cart."
          }
        end
        if cart_item.update(cart_params)
          render status: 200, json: {
            success: true, message: "cart has been updated."
          }
        else
          render status: 400, json: {
            success: false, message: "Failed", errors: cart_item.errors
          }
        end
      end

      def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.delete_with_parent_if_no_child
        render status: 200, json: {
          success: true, message: "product has been successfully removed to your cart."
        }
      end

      private
      def cart_params
        params.require(:cart).permit(:quantity, :notes)
      end
    end
  end
end

