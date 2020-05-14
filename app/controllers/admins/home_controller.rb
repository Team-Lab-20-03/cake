class Admins::HomeController < ApplicationController
	before_action :authenticate_admin!

  def top
    @orders = Order.where("created_at >= ?", Date.today)
    # created_atが本日も新しいもの
  end
end
