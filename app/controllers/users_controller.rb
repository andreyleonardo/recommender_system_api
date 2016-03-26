class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  # POST /v1/users
  # Creates a user
  # { user: {
  #   full_name: "John Doe",
  #   email: "anything@test.com",
  #   password: "[FILTERED]"
  #   }
  # }
  def create
    # first force the email address parameter to lowercase
    # so we can use the validates_uniqueness
    params[:user][:email].downcase!

    # Since we need to create a new User object anyway, leverate the
    # validates_uniquess on email rather than performing a separate
    # query to check if the email is already in use.
    user = User.new user_params

    if user.invalid? && user.errors.include?(:email)
      Rails.logger.info 'email_already_exists'
      render json: { error: 'email_already_exists' }, status: :unprocessable_entity
    else
      # Note: Devise will automatically send email confirmation instructions
      # after a user is created.  Need to wait until after the child object
      # is created since that is where we store their name.
      user.skip_confirmation_notification!
      profile = Profile.new profile_params
      user.profile = profile

      if user.save
        # Now manually trigger the devise email
        # user.send_confirmation_instructions

        render json: user, serializer: SessionSerializer, root: nil

      else
        Rails.logger.error 'errors when creating a user: ' + user.errors.messages.to_s

        warden.custom_failure!
        render json: { error: 'user_create_error' }, status: :unprocessable_entity
      end
    end
  end

  # PUT /v1/users/:user_id/update_email
  # Update email address in the database
  def update_email
    user = User.find params[:user_id]

    user.update email: user_email unless user_email.empty?

    render json: user, root: false
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def profile_params
    params.require(:user).permit(:full_name)
  end

  def user_email
    params[:user][:email]
  end
end
