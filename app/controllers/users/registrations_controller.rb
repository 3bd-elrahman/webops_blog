class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  # def create 
  #   user = User.new(sign_up_params)

  #   if user.save
  #     render json:{message:""}
  #   else
  #   end

  # end

  def sign_up_params 
        #upload image in base 64
    params.require(:user).permit(:name, :email, :password, :password_confirmation,image: :data)
  end

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed
    render json: { message: @user.errors}
  end
end