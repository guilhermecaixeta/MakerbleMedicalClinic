require "rails_helper"

RSpec.describe Appointment, type: :model do
  subject { FactoryBot.build(:appointment) }

  describe "validations" do
    it "is valid when has all required attributes" do
      expect(subject).to be_valid
    end

    it "is invalid when is missing start date time" do
      subject.start_date_time = nil
      expect(subject).to_not be_valid
    end

    it "is invalid when is missing end date time" do
      subject.end_date_time = nil
      expect(subject).to_not be_valid
    end

    it "is invalid when is missing patient" do
      subject.patient = nil
      expect(subject).to_not be_valid
    end

    it "is invalid when is missing doctor" do
      subject.doctor = nil
      expect(subject).to_not be_valid
    end

    it "is invalid when is missing specialty" do
      subject.specialty = nil
      expect(subject).to_not be_valid
    end

    it "is invalid when end date time is lesser than start date time" do
      subject.end_date_time = Time.now - 1.hour
      expect(subject).to_not be_valid
    end

    it "is invalid when is past start date time" do
      subject.start_date_time = Time.now - 1.hours
      expect(subject).to_not be_valid
    end

    it "is invalid when is past end date time" do
      subject.end_date_time = Time.now - 1.hours
      expect(subject).to_not be_valid
    end

    it "is invalid when there is overlapping time" do
      doctor = FactoryBot.create :doctor
      FactoryBot.create(:appointment, :concurrent, doctor: doctor)
      expect(FactoryBot.build(:appointment, doctor: doctor)).to_not be_valid
    end
  end

  describe "Association" do
    it "is valid when has belong to association with specialty" do
      should belong_to(:specialty).without_validating_presence
    end

    it "is valid when has belong to association with patient" do
      should belong_to(:patient).without_validating_presence
    end

    it "is valid when has belong to association with doctor" do
      should belong_to(:doctor).without_validating_presence
    end
  end
end
