require_relative '../lib/district_repository'

class HeadcountAnalyst
  attr_reader :repo, :districts, :economic_profile, :statewide_testing, :data

  def path
    File.expand_path '../data', __dir__
  end

  def initialize(repo)
    @repo = repo
  end

  def districts
    @repo.districts
  end

  def top_statewide_testing_year_over_year_growth_in_3rd_grade(subject)


    # ["WILEY RE-13 JT", 0.3]
  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    if district_2.fetch(:against) == 'state'
      district_2 = ("COLORADO")
    else
      district_2 = district_2.fetch(:against)
    end
    district_1_average = average_kindergarten_participation(district_1)
    district_2_average = average_kindergarten_participation(district_2)
    difference = district_1_average / district_2_average
    truncate(difference)
  end

  #refactor into kindergarten_method_above

  def kindergarten_participation_against_household_income(district)
    district_average_income = average_income_by_district(district)
    state_average_income = average_income_by_district("COLORADO")

    participation_income_variance = (district_average_income.to_f/state_average_income.to_f)
    kindergarten_participation = kindergarten_participation_rate_variation(district, :against => 'state')
    participation_against_income_variance = (kindergarten_participation/participation_income_variance)

    truncate(participation_against_income_variance)
  end

  def kindergarten_participation_correlates_with_household_income(district)
    if district.fetch(:for) == 'state'
      income_correlation_for_all_districts
    else
      participation = kindergarten_participation_against_household_income(district.fetch(:for))
      if participation >= 0.6 && participation <= 1.5
        true
      else
        false
      end
    end
  end

  #NEED TO ADD FUNCTIONALITY FOR COMPARING A SUBSET OF ^^^^^^^^
  # kindergarten_participation_correlates_with_household_income(:across => ['district_1', 'district_2', 'district_3', 'district_4'])


  #### WHEN ARE WE DIVIDING AND WHEN ARE WE SUBTRACTING?? VARIANCE VS. DIFFERENCE ###
  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten_variation = kindergarten_participation_rate_variation(district, :against => 'state')
    kindergarten_graduation_variance = (kindergarten_variation.to_f/grad_diff_from_state(district).to_f)
    result = truncate(kindergarten_graduation_variance)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(district)
    if district == 'state'
      graduation_correlation_for_all_districts
    else
      graduation = kindergarten_participation_against_high_school_graduation(district)
      if graduation >= 0.6 && graduation <= 1.5
        true
      else
        false
      end
    end
  end

  ### Need to be able to compare districts
  ##ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ['district_1', 'district_2', 'district_3', 'district_4']) # => true


  def grad_diff_from_state(district)
    state_average_graduation = average_graduation_rate("COLORADO")
    district_average_graduation = average_graduation_rate(district)

    difference = district_average_graduation / state_average_graduation
    truncate(difference)
  end

  private

  def average_kindergarten_participation(district)
    if districts.has_key?(district)
      district_data = repo.find_by_name(district).enrollment.kindergarten_participation_by_year
      district_average = (district_data.values.inject(0, :+))/(district_data.values.size)
    else
      raise UnknownDataError
    end
  end

  def average_income_by_district(district)
    district_income_data = repo.find_by_name(district).economic_profile.data.fetch(:median_household_income)
    district_average_income = (district_income_data.values.inject(0, :+))/(district_income_data.values.size)
  end



  def average_graduation_rate(district)
    district_graduation_data = repo.find_by_name(district).enrollment.data.fetch(:graduation_rate)
    district_average_graduation = (district_graduation_data.values.inject(0, :+))/(district_graduation_data.values.size)
  end

  def income_correlation_for_all_districts
    results = []
    districts.each_pair do |key, value|
      results << kindergarten_participation_correlates_with_household_income(:for => key)
    end
    number_of_trues = results.count { |e| e == true }
    number_of_falses = results.count { |e| e == false }
    percent = ((number_of_trues.to_f/districts.size)*100).round
    if percent >= 70
      true
    else
      false
    end
  end

  def graduation_correlation_for_all_districts
    results = []
    districts.each_pair do |key, value|
      results << kindergarten_participation_correlates_with_high_school_graduation(key)
    end
    number_of_trues = results.count { |e| e == true }
    number_of_falses = results.count { |e| e == false }
    percent = ((number_of_trues.to_f/districts.size)*100).round
    if percent >= 70
      true
    else
      false
    end
  end

  def truncate(value)
    if value < 0
      value = value.to_s[0..5].to_f
    else
      value = value.to_s[0..4].to_f
    end
    value
  end

end
