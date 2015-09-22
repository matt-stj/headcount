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
    district_2 = ("COLORADO") if district_2 == 'state'
    district_1_average = average_kindergarten_participation(district_1)
    district_2_average = average_kindergarten_participation(district_2)
    difference = district_1_average - district_2_average
    truncate(difference)
  end

  #refactor into kindergarten_method_above

  def kindergarten_participation_against_household_income(district)
    district_average_income = average_income_by_district(district)
    state_average_income = average_income_by_district("COLORADO")

    variation_from_state = (district_average_income.to_f/state_average_income.to_f)
    kindergarten_participation = kindergarten_participation_rate_variation(district, 'state')
    variation = (kindergarten_participation/variation_from_state)

    truncate(variation)
  end

  private

  def average_kindergarten_participation(district)
    district_data = districts.fetch(district).enrollment.kindergarten_participation_by_year
    district_average = (district_data.values.inject(0, :+))/(district_data.values.size)
  end

  def average_income_by_district(district)
    district_income_data = districts.fetch(district).economic_profile.data.fetch(:median_household_income)
    district_average_income = (district_income_data.values.inject(0, :+))/(district_income_data.values.size)
  end

  def truncate(value)
    if value < 0
      value = value.to_s[0..5].to_f
    else
      value = value.to_s[0..4].to_f
    end
  end

end
