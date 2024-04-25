require "rails_helper"

RSpec.describe Manager, type: :model do
  describe "validation" do
    subject { FactoryBot.build(:manager) }

    it "is valid when has all required attributes" do
      expect(subject).to be_valid
    end

    it "is not valid when name is missing" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when birthday is missing" do
      subject.birthday = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when email is missing" do
      subject.email = ""
      expect(subject).to_not be_valid
    end

    it "is not valid when password is missing" do
      subject.password = ""
      expect(subject).to_not be_valid
    end

    it "is not valid when name is too short" do
      subject.name = "aa"
      expect(subject).to_not be_valid
    end
  end

  describe "Association" do
    it "is valid when has one attached to association" do
      should have_one_attached(:avatar)
    end

    it "is valid when has many to association with roles" do
      should have_and_belong_to_many(:roles)
    end
  end
end
