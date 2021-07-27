require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /signup" do
    it "works! (now write some real specs)" do
      get signup_path
      expect(response).to have_http_status(200)
    end

    it "should not have invalid signup information" do
      get signup_path
        assert_no_difference 'User.count' do
          post users_path, params: { user: { name:  "",
            email: "user@invalid",
            password: "foo",
            password_confirmation: "bar"} }
          end
    end



  end
end
