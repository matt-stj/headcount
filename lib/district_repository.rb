require 'csv'
require_relative 'enrollment_loader'
require_relative 'enrollment'
require_relative 'district'
require_relative 'statewide'

class DistrictRepository < LoadFromCSVS
  attr_reader :districts, :statewide_testing

  def self.from_csv(path)
    path = File.expand_path '../data', __dir__

    repo_data ||= {}
    load_pupil_enrollment(path, repo_data, 'Pupil enrollment.csv')
    load_online_pupil_enrollment(path, repo_data, 'Online pupil enrollment.csv')
    load_remediation_in_higher_education(path, repo_data, 'Remediation in higher education.csv')
    load_kindergarteners_in_full_day_program(path, repo_data, 'Kindergartners in full-day program.csv')
    load_special_education(path, repo_data, 'Special education.csv')
    load_high_school_graduation_rates(path, repo_data, 'High school graduation rates.csv')
    load_dropout_rates_by_race(path, repo_data, 'Dropout rates by race and ethnicity.csv')
    load_pupil_enrollment_by_race_ethnicity(path, repo_data, 'Pupil enrollment by race_ethnicity.csv')
    # load_third_grade_students(path, repo_data)
    ###statewide###
    statewide_testing_load_third_grade_students(path, repo_data, '3rd grade students scoring proficient or above on the CSAP_TCAP.csv')
    statewide_testing_load_eight_grade_students(path, repo_data, '8th grade students scoring proficient or above on the CSAP_TCAP.csv')
    statewide_testing_load_math_proficiency_by_race(path, repo_data, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv')
    statewide_testing_load_reading_proficiency_by_race(path, repo_data, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv')
    statewide_testing_load_writing_proficiency_by_race(path, repo_data, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv')
    ###economic#####
    load_median_household_income(path, repo_data, 'Median household income.csv')
    load_school_aged_childen_in_poverty(path, repo_data, 'School-aged children in poverty.csv')
    load_title_one(path, repo_data, 'Title I students.csv')
    load_free_or_reduced_lunch(path, repo_data, 'Students qualifying for free or reduced price lunch.csv')
    # statewide_testing_load_writing_proficiency_by_race_for_all(path, repo_data) SHOULD HAPPEN IN METHOD - NOT BE RELOADED
    repo = DistrictRepository.new(repo_data)
    repo
  end

  def initialize(repository_data)
    @districts = repository_data.map { |name, district_data|
      [name, District.new(name, district_data)]}.to_h
  end

  def find_by_name(name)
    @districts.fetch(name.upcase, nil)
  end

  def find_all_matching(fragment)
    output = []
    @districts.map do |district, value|
      if district.include?(fragment.upcase)
        output << value
      end
    end
    output
  end

  def name(name)
    if @districts.has_key?(name.upcase)
    end
  end
end
