class UserSerializer 

  class << self 

    def create_user(user)
      # binding.pry
      {
        data: {
        type: 'user',
        id: user.id,
        attributes: {
          email: user.email,
          api_key: user.api_key
        }
      }
    }
    end

  end
end