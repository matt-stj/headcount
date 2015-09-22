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

  def top_statewide_testing_year_over_year_growth(subject)

  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    district_1 = districts.fetch(district_1)
    if district_2 == 'state'
      district_2 = districts.fetch("COLORADO")
    else
      district_2 = districts.fetch(district_2)
    end
    district_1_data = district_1.enrollment.kindergarten_participation_by_year
    district_2_data = district_2.enrollment.kindergarten_participation_by_year
    district_1_average = (district_1_data.values.inject(0, :+))/(district_1_data.values.size)
    district_2_average = (district_2_data.values.inject(0, :+))/(district_2_data.values.size)
    difference = district_1_average - district_2_average

    if difference < 0
      difference = difference.to_s[0..5].to_f
    else
      difference = difference.to_s[0..4].to_f
    end
  end

  #refactor into kindergarten_method_above
  def kindergarten_participation_average_for_single_district(district)
    district_data = districts.fetch(district).enrollment.kindergarten_participation_by_year
    district_average = (district_data.values.inject(0, :+))/(district_data.values.size)
  end

  def kindergarten_participation_against_household_income(district)
    district_income_data = districts.fetch(district).economic_profile.data.fetch(:median_household_income)
    district_average_income = (district_income_data.values.inject(0, :+))/(district_income_data.values.size)

    state_income_data = districts.fetch("COLORADO").economic_profile.data.fetch(:median_household_income)
    state_average_income = (state_income_data.values.inject(0, :+))/(state_income_data.values.size)

    variation_from_state = (district_average_income.to_f/state_average_income.to_f)

    kindergarten_participation = kindergarten_participation_rate_variation(district, 'state')

    variation = (kindergarten_participation/variation_from_state)
  end

end
