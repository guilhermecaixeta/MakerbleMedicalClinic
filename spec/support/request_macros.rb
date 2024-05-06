module RequestMacros
  def login_user_before_each
    # Before each test, create and login the user
    before(:each) do
      login_user
    end
  end
end
