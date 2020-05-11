class Admins::CustomersController < ApplicationController
	before_action :authenticate_admin!

# 管理者用 会員一覧
	def index
		@customers = Customer.all
	end

# 管理者用 会員詳細
	def show
		@customer = Customer.find(params[:id])
	end

# 管理者用 会員編集
	def edit
		@customer = Customer.find(params[:id])
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update(customer_params)
			redirect_to admins_customer_path(@customer.id)
		else
			render :edit
		end
	end

	private
	def customer_params
		params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :main_zip_code, :main_address, :phone_number, :is_active)
	end

end
