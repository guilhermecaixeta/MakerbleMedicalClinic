require "rails_helper"

RSpec.describe Role, type: :model do
  describe "validation" do
    subject { FactoryBot.build(:role) }

    it "is valid when has all required attributes" do
      expect(subject).to be_valid
    end

    it "is not valid when name is missing" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when name is too short" do
      subject.name = "aa"
      expect(subject).to_not be_valid
    end
  end

  describe "Association" do
    it "is valid when has many to association with roles" do
      should have_and_belong_to_many(:permissions)
    end
  end
end
