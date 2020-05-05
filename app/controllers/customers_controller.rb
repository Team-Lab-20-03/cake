class CustomersController < ApplicationController

	before_action :authenticate_customer!

  def edit

    @customer = Customer.find(params[:id])

  end

  def update

    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  def show

    @customer = Customer.find(params[:id])

  end

  def bye_confirm
  end

  def bye_bye
    @customer = Customer.find(params[:id])
    if @customer.update!(admittion_status: "bye_bye")
      redirect_to customers_sign_out_path
    end
  end

  private

  def customer_params

    params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :main_zip_code, :main_address, :phone_number, :is_active)

  end

end