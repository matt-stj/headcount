class UnknownDataError < StandardError
end


class StatewideTesting
  attr_reader :statewide_testing

  def initialize(data)
    @data = data
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

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if subject == :math || subject == :reading || subject == :writing
      grade_data = proficient_by_grade(grade)
    else
      raise UnknownDataError
    end
    if grade_data.has_key?(year)
      grade_data.fetch(year).fetch(subject)
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

  def proficient_by_race_or_ethnicity(race)
    #come back to this
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    proficiencies = {
      math: :math_proficiency_by_race,
      reading: :reading_proficiency_by_race,
      writing: :writing_proficiency_by_race
    }

    proficiency = proficiencies.fetch(subject)

    @data.fetch(proficiency).fetch(year).fetch(race)
  end

  def statewide_combining_proficienty_by_race_and_subject(race)
    years_and_all_data_math = @data.fetch(:math_proficiency_by_race)
    years_and_all_data_reading = @data.fetch(:reading_proficiency_by_race)
    years_and_all_data_writing = @data.fetch(:writing_proficiency_by_race)
    #key is race
    #value is hash of years
    #poiting to a hash of subejects
    #that are poiting to the score
  end
end
