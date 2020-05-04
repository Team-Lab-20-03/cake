class Admins::OrdersController < ApplicationController

	# 注文履歴一覧
	def index
		@orders = Order.all
	end

	# 注文履歴詳細
	def show
		@order = Order.find(params[:id])
		@ordered_products = @order.ordered_products
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		# 注文ステータスと製作ステータスの関係
		# if order.ordered_status == "入金確認"
		# 	order.ordered_products.each do |ordered_product|
		# 		ordered_product.update(create_status: "製作待ち")
		# 	end
		end
		redirect_to admins_order_path(@order)
	end

	private
	def order_params
		params.require(:order).permit(:ordered_status)
	end
end
