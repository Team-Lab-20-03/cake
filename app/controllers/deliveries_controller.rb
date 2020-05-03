class DeliveriesController < ApplicationController

def index

	@delivery = Delivery.new

end

def edit

	@delivery_address = Delivery.find(params[:id])

end

def update

	@delivery_address = Delivery.find(params[:id])
	@delivery_address.update
	redirect_to deliveries_path

end

def destroy

	@delivery_address = Delivery.find(params[:id])
	@delivery_address.destroy
	redirect_to deliveries_path

end

end