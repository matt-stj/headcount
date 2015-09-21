class UnknownDataError < StandardError
end

class Enrollment
  attr_reader :annual_enrollment, :enrollment, :data

  def initialize(data)
    @data = data
  end

  def return_nil_when_cant_fetch(year, data)
    if data.has_key?(year)
      data.fetch(year)
    else
      nil
    end
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
    if years.has_key?(year)
      years.fetch(year)
    else
      nil
    end
  end

  def participation_by_race_or_ethnicity(race)
    race_data_by_year = {}
      @data.fetch(:enrollment_by_race).each_pair do |key, value|
      race_data_by_year[key] = value.fetch(race)
      end
      race_data_by_year.each_pair do |key, value|
      if value > 1
        race_data_by_year[key] = (value/participation_in_year(key)).to_s[0..5].to_f.round(3)
      end
    end
    race_data_by_year
  end

  def participation_by_race_or_ethnicity_in_year(year)
    @data.fetch(:enrollment_by_race).fetch(year)
  end



  def proficient_by_grade(grade)
    if grade == 3
      @data.fetch(:third_grade_proficiency)
    elsif grade == 8
      @data.fetch(:eigth_grade_proficiency)
    else
      raise UnknownDataError
    end
  end

  def proficient_for_subject_in_year(subject, year)
    if subject == :math
      @data.fetch(:math_proficiency_by_race).fetch(year).fetch(:"all students")
    elsif subject == :reading
      @data.fetch(:reading_proficiency_by_race).fetch(year).fetch(:"all students")
    elsif subject == :writing
      @data.fetch(:writing_proficiency_by_race).fetch(year).fetch(:"all students")
    else
      raise UnknownDataError
    end
  end

  def 

end
