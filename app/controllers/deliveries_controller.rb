class DeliveriesController < ApplicationController

def index

	@delivery = Delivery.new

end

def create

	@delivery = Delivery.new(delivery_params)
	@delivery.customer_id = current_customer.id
	if @delivery.save
	redirect_to deliveries_path
	else
      render action: :index
    end

end

def edit

	@delivery_address = Delivery.find(params[:id])

end

def update

	@delivery_address = Delivery.find(params[:id])
	if @delivery_address.update(delivery_params)
	redirect_to deliveries_path
	else
      render action: :edit
    end

end

def destroy

	@delivery_address = Delivery.find(params[:id])
	@delivery_address.destroy
	redirect_to deliveries_path

end

private

def delivery_params

    params.require(:delivery).permit(:destination_name, :zip_code, :address)

end

end