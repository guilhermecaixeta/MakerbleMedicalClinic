# typed: true
# frozen_string_literal: true

class PatientService
  def self.create(params)
    @patient = Patient.new(params)

    if @patient.valid?
      @patient.save!
    end

    @patient
  end

  def self.update(params, patient)
    @patient = patient

    @patient.assign_attributes(params)

    if @patient.valid?
      @patient.save!
    end

    @patient
  end
end
