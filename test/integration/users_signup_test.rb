require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invlaid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: {user: { name: "",
                                        email: "user@invalid",
                                        password: "foobarfoo",
                                        password_confirmation: "barfoobar"}}
    end
    assert_response :unprocessable_entity
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.alert"
  end

  test "valid signup information" do
    assert_difference "User.count", 1 do#1は差分
      post users_path, params: { user: {name: "Example User",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password"}}
    end
    follow_redirect!#リダイレクト先のページに移動
    assert_template "users/show"#users/showビューであるか確認
  end
end
