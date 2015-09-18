require 'csv'
require 'pry'
require_relative 'enrollment_loader'
require_relative 'enrollment'
require_relative 'district'

class DistrictRepository < EnrollmentLoader
  attr_reader :path, :districts, :name, :online_enrollment_pupil_repo

  def self.from_csv(file)
    if file == '/Online pupil enrollment.csv'
      load_online_pupil_enrollment
      DistrictRepository.new(@online_enrollment_pupil_repo)
    elsif file == '/Pupil enrollment.csv'
      load_pupil_enrollment
      DistrictRepository.new(@enrollment_pupil_repo)
    elsif file == '/Remediation in higher education.csv'
      load_remediation_in_higher_education
      DistrictRepository.new(@enrollment_remediation_repo)
    elsif file == '/Kindergartners in full-day program.csv'
      load_kindergarteners_in_full_day_program
      DistrictRepository.new(@enrollment_kindegarten_programs_repo)
    elsif file == '/High school graduation rates.csv'
      load_high_school_graduation_rates
      DistrictRepository.new(@high_school_grad_rates_repo)
    elsif file == '/Special education.csv'
      load_special_education
      DistrictRepository.new(@special_education_repo)
    end
  end

  def initialize(repository_data)
    @districts = repository_data.map { |name, district_data|
      [name, District.new(district_data)]}.to_h
  end

  def find_by_name(name)
    if !@districts.has_key?(name) == true
      return nil
    else
      @districts.fetch(name)
    end
  end

  def name(name)
    if @districts.has_key?(name.upcase)
      return name.upcase
    end
  end

end
