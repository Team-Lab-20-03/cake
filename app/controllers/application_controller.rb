class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

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
