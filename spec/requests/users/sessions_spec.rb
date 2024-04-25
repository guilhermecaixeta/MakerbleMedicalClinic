#./spec/requests/sessions_spec.rb
require "rails_helper"

RSpec.describe "Users::Sessions", type: :request do
  it "signs user in and out" do
    user = create(:user)    ## uncomment if using FactoryBot
    sign_in user
    get root_path
    expect(response).to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.

    sign_out user
    get root_path
    expect(response).not_to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.
  end
end
