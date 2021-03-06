class OrdersController < ApplicationController
  #actionに飛ばないようにフィルターがけ
  before_action :no_cart_item, only: [:new, :confirm, :create]

  def index
    @orders = current_customer.orders.order("created_at DESC")
    # 取得した値に対して条件指定しての並び替え
  end

  def show
    @order = Order.find(params[:id])
    @ordered_products = @order.ordered_products
  end

  def new
    @order = Order.new
    @delivery = Delivery.new
  end

  def confirm  #new.htmlの確認画面へのボタン 仮保存イメージ
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new
    @is_credit = params[:is_credit] #送られてきた情報を格納
    case params[:delivery_address_button]
    when "ご自身の住所"
      @delivery_zip_code = current_customer.main_zip_code
      @delivery_address = current_customer.main_address
      @delivery_name = current_customer.last_name + current_customer.first_name
      @delivery_param = params[:delivery_address_button] #ラジオボタン識別
    when "登録済み住所から選択"
      @delivery_zip_code = Delivery.find(params[:delivery]).zip_code
      @delivery_address = Delivery.find(params[:delivery]).address
      @delivery_name = Delivery.find(params[:delivery]).destination_name
      @delivery_param = params[:delivery_address_button]
    when "新しいお届け先"
      if params[:delivery_zip_code].blank? || params[:delivery_address].blank? || params[:destination_name].blank?
        @order = Order.new #再定義
        @delivery = Delivery.new #再定義
        flash[:notice] = "必要事項をご入力ください"
        render :new
      end
      @delivery_zip_code = params[:delivery_zip_code] #view入力されたものを代入
      @delivery_address = params[:delivery_address]
      @delivery_name = params[:destination_name]
      @delivery_param = params[:delivery_address_button]
    end
  end

  def create  #confirm.htmlの注文決定ボタン

    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save    #支払方法、住所の保存
    current_customer.cart_items.each do |item|
      order_product = OrderedProduct.new #order_product=購入を決定した段階
      order_product.product_id = item.product.id
      order_product.order_id = @order.id
      order_product.quantity = item.quantity
      order_product.price = item.product.tax_price
      order_product.name = item.product.name
      order_product.save  #商品関連の保存
      item.destroy  #１つずつカートをからに
    end
    # if 新規登録先ならば配送先登録
    if (params[:is_new] === "新しいお届け先")
    Delivery.create(customer_id: current_customer.id, destination_name: @order.delivery_name, zip_code: @order.delivery_zip_code, address: @order.delivery_address)
      #↑新しい住所を選んだ時にデリバリーテーブルに保存
    end
    redirect_to thanks_orders_path
  end

  def thanks #viewの表示のみ
  end

  private
  def order_params
    params.require(:order).permit(:total_price, :is_credit, :delivery_name, :delivery_zip_code, :delivery_address)
  end

  def no_cart_item
    if current_customer.cart_items.blank?
      redirect_to products_path
      flash[:notice] = "カートに入れてから情報入力に進んでください"
    end
  end

end
