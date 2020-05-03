class CustomersController < ApplicationController

	before_action :authenticate_customer!

def edit

	@customer = Customer.find(current_customer.id)

end

def show

	@customer = Customer.find(current_customer.id)

end

end

def bye_confirm
end

end
