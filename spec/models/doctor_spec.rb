require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe "validation" do
    subject { FactoryBot.build(:doctor) }

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
    it "is valid when has belong to association with specialty" do
      should belong_to(:specialty).without_validating_presence
    end

    it "is valid when has one attached to association" do
      should have_one_attached(:avatar)
    end

    it "is valid when has many to association with roles" do
      should have_and_belong_to_many(:roles)
    end

    it "is valid when has many to association with appointment" do
      should have_many(:appointments)
    end
  end
end
