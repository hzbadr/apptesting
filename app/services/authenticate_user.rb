class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    Auth::JsonWebToken.encode(user_id: user.id) if user
  end

  private
    attr_reader :email, :password

    def user
      user = User.find_by(email: email)
      return user if user && user.authenticate(password)

      raise(ExceptionHandler::AuthenticationError, "Invalid Credentials")
  end
end
