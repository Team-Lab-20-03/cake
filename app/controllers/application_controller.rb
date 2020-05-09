class ApplicationController < ActionController::Base
		#悪意あるpostメソッドを防ぐ
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	helper_method :current_cart

  # ログイン後のリダイレクト先
	def after_sign_in_path_for(resource_or_scope)
	  if resource_or_scope.is_a?(Admin)
	    admins_home_top_path
	  else
	    root_path
	  end
	end

  #ログアウト後のリダイレクト先
	def after_sign_out_path_for(resource_or_scope)
	  if resource_or_scope == :admin
	    new_admin_session_path
	  else
	    root_path
	  end
	end


	def current_cart
		if session[:customer_id]
			@customer = Customer.find(session[:customer_id])
		else
			@customer = Customer.create
			session[:customer_id] = @customer.id
		end
	end

	private
    def set_search_product
      # 検索バー表示のために常に@qを生成する
      # 検索時以外params[:q]はnilだが、空のransackオブジェクト生成の動作になる
      @q = Product.ransack(params[:q])
    end


	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :main_zip_code, :main_address, :phone_number])
	end
	#追加したカラムをすべて記述する。
end
