require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do

  def setup
    @user = users(:michael)
  end

  describe "GET /users_logins" do
    it "logins user with valid information" do
      get login_path
      post login_path, params: { session: {email: setup(@user.email), password: 'password'}}
    end

    it "logins with invalid information" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email: "", password: "" } }
      assert_template 'sessions/new'
      assert_not flash.empty?
      get root_path
      assert flash.empty?
    end
  end
end
