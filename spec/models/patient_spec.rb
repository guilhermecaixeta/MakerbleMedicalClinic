require "rails_helper"

RSpec.describe Patient, type: :model do
  describe "validation" do
    subject { FactoryBot.build(:patient) }

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
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when address is missing" do
      subject.address = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when phone is missing" do
      subject.phone = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when name is too short" do
      subject.name = "aa"
      expect(subject).to_not be_valid
    end

    it "is not valid when email is too short" do
      subject.email = "aa"
      expect(subject).to_not be_valid
    end

    it "is not valid when phone is too short" do
      subject.phone = "aa"
      expect(subject).to_not be_valid
    end

    it "is not valid when birthday is in future" do
      subject.birthday = Time.now + 1.day
      expect(subject).to_not be_valid
    end
  end

  describe "Association" do
    it "is valid when has many to association with appointment" do
      should have_many(:appointments)
    end
  end
end
