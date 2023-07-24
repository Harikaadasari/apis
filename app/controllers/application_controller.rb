class ApplicationController < ActionController::Base
	 protect_from_forgery with: :null_session
	 protect_from_forgery with: :exception, unless: -> { request.format.json? }
     skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
end
