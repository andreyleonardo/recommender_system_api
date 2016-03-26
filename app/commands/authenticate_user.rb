class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user = validate_user
    return unless user
    JsonWebToken.encode(
      user_id: user.id,
      candidate_id: (user.candidate.id unless user.candidate.nil?),
      recruiter_id: (user.recruiter.id unless user.recruiter.nil?))
  end

  private

  attr_accessor :email, :password

  def validate_user
    user = User.find_for_database_authentication(email: email)
    return user if user && user.valid_password?(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
