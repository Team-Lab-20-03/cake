class CustomersController < ApplicationController

	before_action :authenticate_customer!

  def show
	  @customer = Customer.find(params[:id])
  end

  def edit
	  @customer = Customer.find(params[:id])

  end

  def update
	  @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customers_path
  end

  def bye_confirm
	@customer = Customer.find(params[:id])
    # @current_customer.update(params[:id])
    # redirect_to root_path
  end

  def bye_bye
  	@customer = Customer.find(current_customer.id)
  	@customer.update(is_active: '退会済み')
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:is_active, :email, :last_name, :first_name, :kana_last_name, :kana_first_name, :phone_number, :main_zip_code, :main_address )
  end

end
