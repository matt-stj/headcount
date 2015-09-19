class Enrollment
  attr_reader :annual_enrollment, :enrollment

  def initialize(data)
    @data = data
  end

  def in_year(year)
    participation_by_year.fetch(year)
  end

  def participation_in_year(year)
    participation_by_year.fetch(year)
  end

  def participation_by_year
    @data.fetch(:pupil_enrollment)
  end

  def online_participation_in_year(year)
    online_participation_by_year.fetch(year)
  end

  def online_participation_by_year
    @data.fetch(:online_enrollment)
  end

  def graduation_rate_in_year(year)
    @data.fetch(year)
  end

  def graduation_rate_by_year
    @data
  end

  def special_education_in_year(year)
    special_education_by_year.fetch(year)
  end

  def special_education_by_year
    @data.fetch(:special_education)
  end

  def remediation_in_year(year)
    remediation_by_year.fetch(year)
  end

  def remediation_by_year
    @data.fetch(:remediation)
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation_by_year.fetch(year)
  end

  def kindergarten_participation_by_year
    @data.fetch(:kindergartner_enrollment)
  end
  # def participation_by_race_or_ethnicity(race)
  #
  # end
end
