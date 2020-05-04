class CustomersController < ApplicationController

	before_action :authenticate_customer!

def edit

	@customer = Customer.find(current_customer.id)

end

def show

	@customer = Customer.find(current_customer.id)

end

def update

end

def bye_confirm

	@customer = Customer.find(current_customer.id)
    if @customer.update!(admittion_status: "bye_confirm")

      redirect_to customers_sign_out_path
  end
end

end
