require 'csv'
require 'pry'
require_relative 'enrollment_loader'
require_relative 'enrollment'
require_relative 'district'
require_relative 'statewide'

class DistrictRepository < EnrollmentLoader
  attr_reader :path, :districts, :name, :online_enrollment_pupil_repo

  def self.from_csv(file_or_path)
    # eventually we should just receive the path and not have this stuff
    if File.directory? file_or_path
      path = file_or_path
    else
      file = file_or_path
      path = File.expand_path '../data', __dir__
    end

    # eventually (meaning once all the ones below are correct)
    # repo_data = CsvLoader.new(path).load
    # DistrictRepository.new(repo_data)

    repo_data = {}
    load_online_pupil_enrollment(path, repo_data)
    load_pupil_enrollment(path, repo_data)
    load_remediation_in_higher_education(path, repo_data)
    repo = DistrictRepository.new(repo_data)

    if file == '/Kindergartners in full-day program.csv'
      load_kindergarteners_in_full_day_program
      repo = DistrictRepository.new(@enrollment_kindegarten_programs_repo)
    elsif file == '/High school graduation rates.csv'
      load_high_school_graduation_rates
      repo = DistrictRepository.new(@high_school_grad_rates_repo)
    elsif file == '/High school graduation rates.csv'
      load_special_education
      repo = DistrictRepository.new(@enrollment_special_education_repo)
    elsif file == '/Dropout rates by race and ethnicity.csv'
      load_special_education
      repo = DistrictRepository.new(@enrollment_dropout_by_race_repo)
    elsif file == '/Special education.csv'
      load_special_education
      repo = DistrictRepository.new(@special_education_repo)
    elsif file == '/Pupil enrollment by race_ethnicity.csv'
      load_pupil_enrollment_by_race_ethnicity
      repo = DistrictRepository.new(@pupil_enrollment_by_race_ethnicity_repo)
    # elsif file == '/3rd grade students scoring proficient or above on the CSAP_TCAP.csv'
    #   load_third_grade_students
    #   repo = DistrictRepository.new(@third_grade_test_scores_repo)
    end
    repo
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
