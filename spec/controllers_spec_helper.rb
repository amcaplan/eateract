def login
  page.set_rack_session(:user_id => User.first.id)
end