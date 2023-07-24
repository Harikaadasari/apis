class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:signup, :login, :create_project]

  def signup
    user = User.new(user_params)

    if user.save
      render json: { message: 'User created successfully' }
    else
      render json: { message: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def create_project
    user = User.find(params[:user_id])
    project = user.projects.build(name: params[:name])

    if project.save
      render json: { message: 'Project created successfully' }
    else
      render json: { message: 'Failed to create project' }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Generate a JWT token (you'll need to install the 'jwt' gem)
      token = JWT.encode({ user_id: user.id }, 'your_secret_key', 'HS256')

      render json: { login_token: token }
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :mobile, :email, :password, :password_confirmation)
  end
end
