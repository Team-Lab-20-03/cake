class CustomersController < ApplicationController

	before_action :authenticate_customer!

def show

	@customer = Customer.find(current_customer.id)

end

def edit

	@customer = Customer.find(current_customer.id)

end

def update

	@customer = Customer.find(current_customer.id)
    @customer.update
    redirect_to customers_path
end

def bye_confirm

	@customer = Customer.find(current_customer.id)
    if @customer.update!(admittion_status: "bye_confirm")

      redirect_to customers_sign_out_path
  end
end

end
