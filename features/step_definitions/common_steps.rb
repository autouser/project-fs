Given(/^I have logged in as an user$/) do
  @username = 'user@mail.com'
  @password = 'test1234'
  @user = User.create! email: @username, password: @password

  visit new_user_session_path

  fill_in "Email", with: @username
  fill_in "Password", with: @password


  click_button "Sign in"

  page.current_path.should eq('/')
end
