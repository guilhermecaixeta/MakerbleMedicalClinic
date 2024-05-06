#./spec/requests/sessions_spec.rb
require "rails_helper"

RSpec.describe "Users::Sessions", type: :request do
  it "signs user in and out" do
    manager = FactoryBot.create(:manager_with_role)
    sign_in manager
    get root_path
    expect(response).to render_template(:index)

    sign_out manager
    get root_path
    expect(response).not_to render_template(:index)
  end
end
