require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:email)}
  it { should validate_uniqueness_of(:api_key)}
  it { should validate_presence_of(:password_digest)}
  it { should have_secure_password }

  it 'makes a randomly generated api key' do 
    user_data = {
      email: 'thepoordodos@sailence.com',
      password: 'yugioh',
      password_confirmation: 'yugioh' 
    }

    user = User.new(user_data)
    binding.pry
    expect(user.random_key.length).to eq(26)
  end
end
