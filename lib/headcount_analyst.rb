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

    participation_income_variance = (district_average_income.to_f/state_average_income.to_f)
    kindergarten_participation = kindergarten_participation_rate_variation(district, 'state')
    participation_against_income_variance = (kindergarten_participation/participation_income_variance)

    truncate(participation_against_income_variance)
  end

  def kindergarten_participation_correlates_with_household_income(district)
    participation = kindergarten_participation_against_household_income(district)
    if participation >= 0.6 && participation <= 1.5
      true
    else
      false
    end
  end

  #### WHEN ARE WE DIVIDING AND WHEN ARE WE SUBTRACTING?? VARIANCE VS. DIFFERENCE ###
  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten_variation = kindergarten_participation_rate_variation(district, 'state')
    district_grad_rate = average_graduation_rate(district)
    state_grad_rate = average_graduation_rate("COLORADO")
    grad_variance = district_grad_rate/state_grad_rate
    grad_variance
    kindergarten_graduation_variance = (kindergarten_variation/grad_variance)
    truncate(kindergarten_graduation_variance)
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

  def graduation_variation(district)
    state_average_graduation = average_graduation_rate("COLORADO")
    district_average_graduation = average_graduation_rate(district)

    difference = district_1_average - district_2_average
    truncate(difference)
  end

  def average_graduation_rate(district)
    district_graduation_data = repo.find_by_name(district).enrollment.data.fetch(:graduation_rate)
    district_average_graduation = (district_graduation_data.values.inject(0, :+))/(district_graduation_data.values.size)
  end

  def truncate(value)
    if value < 0
      value = value.to_s[0..5].to_f
    else
      value = value.to_s[0..4].to_f
    end
  end

end
