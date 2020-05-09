class Admins::OrdersController < ApplicationController
	# before_action :authenticate_admin!

	# 注文履歴一覧
	def index
		request_referer = Rails.application.routes.recognize_path(request.referer)
		controller = request_referer[:controller]
		action = request_referer[:action]

		# トップページからは今日の注文を表示
		if controller == "admins/home" && action == "top"
			@orders = Order.where("created_at >= ?", Date.today)

		# 会員詳細ページからは会員の注文履歴を表示
		elsif controller == "admins/customers" && action == "show"
			@orders = Order.where('customer_id = ?', request_referer[:id])

		#	全ての注文を表示
		else
			@orders = Order.all
		end
	end

	# 注文履歴詳細
	def show
		@order = Order.find(params[:id])
		@ordered_products = @order.ordered_products
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		# 注文ステータスが入金確認 => 製作ステータスを製作待ち
		if @order.ordered_status == "入金確認"
			@order.ordered_products.each do |ordered_product|
				ordered_product.update(create_status: "製作待ち")
			end
		end
		redirect_to admins_order_path(@order)
	end

	private
	def order_params
		params.require(:order).permit(:ordered_status)
	end
end
