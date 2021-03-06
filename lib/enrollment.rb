class UnknownDataError < StandardError
end

class UnknownRaceError < StandardError
end

class Enrollment
  attr_reader :annual_enrollment, :enrollment, :data, :statewide_testing

  def initialize(data)
    @data = data
  end

  def return_nil_when_cant_fetch(year, data)
    data.fetch(year) if data.key?(year)
  end

  def in_year(year)
    participation_by_year.fetch(year)
  end

  def participation_in_year(year)
    data = participation_by_year
    return_nil_when_cant_fetch(year, data)
  end

  def participation_by_year
    @data.fetch(:pupil_enrollment)
  end

  def online_participation_in_year(year)
    data = online_participation_by_year
    return_nil_when_cant_fetch(year, data)
  end

  def online_participation_by_year
    @data.fetch(:online_enrollment)
  end

  def graduation_rate_in_year(year)
    data = graduation_rate_by_year
    return_nil_when_cant_fetch(year, data)
  end

  def graduation_rate_by_year
    @data.fetch(:graduation_rate)
  end

  def special_education_in_year(year)
    data = special_education_by_year
    return_nil_when_cant_fetch(year, data)
  end

  def special_education_by_year
    @data.fetch(:special_education)
  end

  def remediation_in_year(year)
    data = remediation_by_year
    return_nil_when_cant_fetch(year, data)
  end

  def remediation_by_year
    @data.fetch(:remediation)
  end

  def kindergarten_participation_in_year(year)
    data = kindergarten_participation_by_year
    return_nil_when_cant_fetch(year, data)
  end

  def kindergarten_participation_by_year
    @data.fetch(:kindergartner_enrollment)
  end

  def dropout_rate_in_year(year)
    data = @data.fetch(:dropout_rate_by_race)
    data.fetch(year).fetch(:all_students) if data.key?(year)
  end

  def dropout_rate_by_gender_in_year(year)
    wanted_keys = [:female, :male]
    data = @data.fetch(:dropout_rate_by_race)
    if data.key?(year)
      data.fetch(year).select { |key, _| wanted_keys.include? key }
    end
  end

  def dropout_rate_by_race_in_year(year)
    wanted_keys = [:asian,
                   :black,
                   :pacific_islander,
                   :hispanic,
                   :native_american,
                   :two_or_more,
                   :white
                  ]
    data = @data.fetch(:dropout_rate_by_race)
    if data.key?(year)
      data.fetch(year).select { |key, _| wanted_keys.include? key }
    end
  end

  def dropout_rate_for_race_or_ethnicity(race)
    data = @data.fetch(:dropout_rate_by_race)
    race_data_by_year = {}
    data.each_pair do |key, value|
      if value.key?(race)
        race_data_by_year[key] = value.fetch(race, UnknownRaceError)
      else
        fail UnknownRaceError
      end
    end
    race_data_by_year
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    years = dropout_rate_for_race_or_ethnicity(race)
    years.fetch(year) if years.key?(year)
  end

  def participation_by_race_or_ethnicity(race)
    data = @data.fetch(:enrollment_by_race)
    race_data_by_year = {}
    data.each_pair do |key, value|
      if value.key?(race) == false
        fail UnknownRaceError
      else
        race_data_by_year[key] = value.fetch(race, UnknownRaceError)
      end
    end
    race_data_by_year
  end

  def participation_by_race_or_ethnicity_in_year(year)
    wanted_keys = [:native_american, :asian, :black, :hispanic, :pacific_islander,
                   :two_or_more, :white]
    data = @data.fetch(:enrollment_by_race)
    if data.key?(year)
      data.fetch(year).select { |key, _| wanted_keys.include? key }
    end
  end
end
