# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  

  describe "User validations" do 
    subject(:user) { User.new(username: "username", password: "password")}

    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:session_token)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_uniqueness_of(:username)}
    it { should validate_uniqueness_of(:session_token)}
  end

  describe "User::find_by_credentials" do
    it "finds the right user" do 
      user = User.create!(username: "username", password: "password")
      test = User.find_by_credentials("username", "password")
      expect(test).to eq(user)
    end
  end
  

end
