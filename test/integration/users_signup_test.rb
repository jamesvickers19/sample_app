require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "test that account does not work without approval" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: "Example User",
                                            email: "user@example.com",
                                            password: "password",
                                            password_confirmation: "password" }
    end
    user = assigns(:user)
    assert_not user.approved?
    assert_not user.activated?
    # Activate the user, but do not approve them.
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    assert_not user.reload.approved?
    # Try to log in as user, with account that is activated but not approved.
    # Check that redirect happens
    log_in_as(user)
    assert_redirected_to root_url
    assert_not is_logged_in?
  end

  test "valid signup information with account activation and approval" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: "Example User",
                                            email: "user@example.com",
                                            password: "password",
                                            password_confirmation: "password" }
    end
    # Assert 2 deliveries, one for user activation and one for adminstrator approval.
    assert_equal 2, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    assert_not user.approved?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    assert_not user.activated?
    # Invalid approval token
    get edit_account_approval_path("invalid token")
    assert_not is_logged_in?
    assert_not user.approved?
    # Valid token, wrong email (activation)
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    assert_not user.activated?
    # Valid token, wrong email (approval)
    get edit_account_approval_path(user.approval_token, email: 'wrong')
    assert_not user.approved?
    # Valid activation token and approval token
    get edit_account_approval_path(user.approval_token, email: user.email)    
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    assert user.reload.approved?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "user@invalid",
                               password: "foo",
                               password_confirmation: "bar"}
    end
    assert_template 'users/new'
  end
  
end
