class UnknownDataError < StandardError
end

class Enrollment
  attr_reader :annual_enrollment, :enrollment, :data

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
    graduation_rate_by_year.fetch(year)
  end

  def graduation_rate_by_year
    @data.fetch(:graduation_rate)
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

  ## FOR ALL BELOW  - RETURN NIL WHEN NO VALUE AND ERROR MESSAGE WHEN NEEDED

  def dropout_rate_in_year(year)
    data = @data.fetch(:dropout_rate_by_race)
    if data.has_key?(year)
      data.fetch(year).fetch(:all_students)
    else
      nil
    end
  end

  def dropout_rate_by_gender_in_year(year)
    wanted_keys = [:female, :male]
    data = @data.fetch(:dropout_rate_by_race)
    if data.has_key?(year)
      data.fetch(year).select { |key,_| wanted_keys.include? key }
    else
      nil
    end
  end

  def dropout_rate_by_race_in_year(year)
    wanted_keys = [ :asian,
                    :black,
                    :pacific_islander,
                    :hispanic,
                    :native_american,
                    :two_or_more,
                    :white
                  ]
    data = @data.fetch(:dropout_rate_by_race)
    if data.has_key?(year)
      data.fetch(year).select { |key,_| wanted_keys.include? key }
    else
      nil
    end
  end

  def dropout_rate_for_race_or_ethnicity(race)
    data = @data.fetch(:dropout_rate_by_race)
    race_data_by_year = {}
    data.each_pair do |key, value|
      if value.has_key?(race) == false
        raise UnknownDataError
      end
        race_data_by_year[key] = value.fetch(race)
    end
    race_data_by_year
  end



  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    years = dropout_rate_for_race_or_ethnicity(race)
    years.fetch(year)
  end

end
