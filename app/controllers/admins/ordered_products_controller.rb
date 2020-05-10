class Admins::OrderedProductsController < ApplicationController

	def update
		ordered_product = OrderedProduct.find(params[:id])
		ordered_product.update(ordered_product_params)
		case ordered_product.create_status
		when "製作中"
			ordered_product.order.update(ordered_status: "製作中")
		when "製作完了"
			if ordered_product.order.ordered_products.all?{|ordered_product| ordered_product.create_status === "製作完了"}
				ordered_product.order.update(ordered_status: "発送準備中")
			end
		end

		redirect_to admins_order_path(ordered_product.order.id)
	end


	private
	def ordered_product_params
		params.require(:ordered_product).permit(:create_status)
	end
end
