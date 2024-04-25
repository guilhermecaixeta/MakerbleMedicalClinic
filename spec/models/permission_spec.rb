require "rails_helper"

RSpec.describe Permission, type: :model do
  describe "validation" do
    subject { FactoryBot.build(:permission) }

    it "is valid when has all required attributes" do
      expect(subject).to be_valid
    end

    it "is not valid when title is missing" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when scope is missing" do
      subject.scope = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when title is too short" do
      subject.title = "aa"
      expect(subject).to_not be_valid
    end

    it "is not valid when scope is too short" do
      subject.title = "aa"
      expect(subject).to_not be_valid
    end
  end
end
