require "rails_helper"

RSpec.configure do |c|
  c.include BackofficeHelper
end

RSpec.describe BackofficeHelper, type: :helper do
  describe "Policy for" do
    it "Administrator can read and write scope" do
      manager = FactoryBot.create(:manager_with_role)

      policy = policy_for manager, Backoffice::CalendarController.controller_path

      should_read_and_write = policy.can_read_and_write?

      expect(should_read_and_write).to eq(true)
    end

    it "Operator can read and write" do
      operator = FactoryBot.create(:operator_with_role)

      policy = policy_for operator, Backoffice::PatientsController.controller_path

      should_read_and_write = policy.can_read_and_write?

      expect(should_read_and_write).to eq(true)
    end

    it "Doctor can read and write" do
      doctor = FactoryBot.create(:doctor_with_role)

      policy = policy_for doctor, Backoffice::CalendarController.controller_path

      should_read_and_write = policy.can_read_and_write?

      expect(should_read_and_write).to eq(true)
    end

    it "Operator cannot read and write" do
      operator = FactoryBot.create(:operator_with_role)

      policy = policy_for operator, Backoffice::DoctorsController.controller_path

      should_read_and_write = policy.can_read_and_write?

      expect(should_read_and_write).to eq(false)
    end

    it "Doctor cannot read and write" do
      doctor = FactoryBot.create(:doctor_with_role)

      policy = policy_for doctor, Backoffice::AppointmentsController.controller_path

      should_read_and_write = policy.can_read_and_write?

      expect(should_read_and_write).to eq(false)
    end
  end

  describe "User edit path for" do
    it "manager" do
      user = FactoryBot.create(:manager_with_role)

      path = backoffice_user_edit_path user

      expect(path).to eq(edit_backoffice_manager_path(user))
    end

    it "doctor" do
      user = FactoryBot.create(:doctor_with_role)

      path = backoffice_user_edit_path user

      expect(path).to eq(edit_backoffice_doctor_path(user))
    end

    it "operator" do
      user = FactoryBot.create(:operator_with_role)

      path = backoffice_user_edit_path user

      expect(path).to eq(edit_backoffice_operator_path(user))
    end
  end

  describe "Get default path for" do
    it "manager" do
      user = FactoryBot.create(:manager_with_role)

      path = get_default_path_for_user user, root_path

      expect(path).to eq(root_path)
    end

    it "doctor" do
      user = FactoryBot.create(:doctor_with_role)

      path = get_default_path_for_user user, root_path

      expect(path).to eq(root_path)
    end

    it "operator" do
      user = FactoryBot.create(:operator_with_role)

      path = get_default_path_for_user user, root_path

      expect(path).to eq(backoffice_calendar_index_path)
    end
  end
end
