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
    @orders = current_customer.order
  end

  def confirm  #new.htmlの確認画面へのボタン
    @order = current_customer.orders.new(order_params)
    case params[:delivery_address_button]
    when "ご自身の住所"
      @order.delivery_zip_code = current_customer.main_zip_code
      @order.delivery_address = current_customer.main_address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    when "登録済住所から選択"
      @order.delivery_zip_code = Delivery.find(order.delivery.id).zip_code
      @order.delivery_address = Delivery.find(order.delivery.id).address
      @order.delivery_name = Delivery.find(order.delivery.id).destination_name
    end
  end

  def create  #confirm.htmlの注文決定ボタン
    @order = Order.new(order_params)
    @order.save    #支払方法、住所の保存
    @order_products = OrderedProduct.new(product_id: cart_item.product_id, quantity: cart_item.quantity, ordered_price: cart_item.product.tax_price, order_id: @order.id)
    @order_products.save　　　#商品関連の保存
    Delivery.create(customer_id: current_customer.id, destination_name: @order.delivery_name, zip_code: @order.delivery_zip_code, address: delivery_address)
      #↑新しい住所を選んだ時にデリバリーテーブルに保存
    current_customer.cart_items.destroy_all  #カート内をカラに
    redirect_to thanks_orders_path
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:total_price, :is_credit, :delivery_name, :delivery_zip_code, :delivery_address)
  end

end
