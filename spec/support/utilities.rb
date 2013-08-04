def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def http_success
  expect(response).to be_success
end

def expect_template(view)
  expect(response).to render_template(view)
end
