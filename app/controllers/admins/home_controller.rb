class Admins::HomeController < ApplicationController
  def top
    @orders = Order.where("created_at >= ?", Date.today)
  end
end
