module RequestMacros
  def login_user
    # Before each test, create and login the user
    before(:each) do
      sign_in FactoryBot.create(:user)
    end
  end

  def logout_user
    # Before each test, create and logout the user
    before(:each) do
      sign_out FactoryBot.create(:user)
    end
  end
end
