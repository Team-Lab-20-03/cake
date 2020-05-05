class OrdersController < ApplicationController

  def index

    @orders = current_customer.orders.order("created_at DESC")
    # 取得した値に対して条件指定しての並び替え

  end

  def show

    @order = Order.find(params[:id])

  end

  def new

    @order = Order.new
    @delivery = Delivery.new

  end

  def confirm
  end

  def thanks
  end
end
