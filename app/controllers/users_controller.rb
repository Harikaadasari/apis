class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:signup, :login]
  def signup
    user = User.new(user_params)
    
    if user.save
      render json: { status: 200 }
    else
      render json: { status: 500 }
    end
  end

  def login
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      # Generate a JWT token (you'll need to install the 'jwt' gem)
      token = JWT.encode({ user_id: user.id }, 'your_secret_key', 'HS256')
      
      render json: { status: 200, login_token: token }
    else
      render json: { status: 401, message: 'Invalid email or password' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :mobile, :email, :password, :password_confirmation)
  end
end
