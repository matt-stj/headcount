class Enrollment
  attr_reader :annual_enrollment, :enrollment

  def initialize(data)
    @data = data
  end

  def in_year(year)
    @data.fetch(year)
  end

  def online_participation_in_year(year)
    @data.fetch(year)
  end

  def graduation_rate_in_year(year)
    @data.fetch(year)
  end

  def special_education_in_year(year)
    @data.fetch(year)
  end

  def participation_by_race_or_ethnicity(race)

  end
end
