class AuthenticationController < ApplicationController
  before_filter :authenticate_request!, only: :ok

  def ok
    render json: { authenticated: true }
  end

  def sign_up
    user = User.new(user_params)
    if user.valid?
      user.save!
      render json: payload(user)
    else
      render json: { errors: user.errors }
    end
  end

  def authenticate_user
    user = User.find_for_database_authentication(email: user_params[:email])
    if user && user.valid_password?(user_params[:password])
      render json: payload(user)
    else
      render json: {errors: { user: ['Invalid Username/Password'] }}, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
      user: {
        auth_token: JsonWebToken.encode({user_id: user.id}),
        id: user.id,
        email: user.email
      }
    }
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
