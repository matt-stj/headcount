require_relative '../lib/district_repository'

class HeadcountAnalyst
  attr_reader :repo, :districts, :economic_profile, :statewide_testing

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
    district_data = districts.fetch("COLORADO").statewide_testing
    data_by_subject = district_data.data.fetch(:third_grade_proficiency).map { |year, proficiencies|
                      year = year, proficiencies = proficiencies.fetch(subject)
                        }.to_h
    min_max ||= data_by_subject.minmax_by { |year, proficiency|
                year
              }
    growth = (min_max[0][1] - min_max[1][1])
    if growth < 0
      growth.to_s[0..5].to_f
    else
      growth.to_s[0..4].to_f
    end
  end

  def top_statewide_testing_year_over_year_growth_in_8th_grade(subject)

  end

  def kindergarten_participation_rate_variation(district)
    state = districts.fetch("COLORADO")
    state_data = state.enrollment.kindergarten_participation_by_year
    district = districts.fetch(district)
    district_data = district.enrollment.kindergarten_participation_by_year
    state_average = (state_data.values.inject(0, :+))/(state_data.values.size)
    district_average = (district_data.values.inject(0, :+))/(district_data.values.size)
    difference = district_average - state_average

    if difference < 0
      difference = difference.to_s[0..5].to_f
    else
      difference = differnce.to_s[0..4].to_f
    end

    #compares the input distric's kindergarten participation to the state
    #returns percent difference compared to state average
  end

end
