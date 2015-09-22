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
    proficiencies = {
      math: :math_proficiency_by_race,
      reading: :reading_proficiency_by_race,
      writing: :writing_proficiency_by_race
    }

    math = proficiencies.fetch(:math)
    reading = proficiencies.fetch(:reading)
    writing = proficiencies.fetch(:writing)

    math_proficiency = @data.fetch(:math_proficiency_by_race)
    reading_proficiency = @data.fetch(:reading_proficiency_by_race)
    writing_proficiency = @data.fetch(:writing_proficiency_by_race)

    math_proficiencies = math_proficiency.reduce({}) { |result, pair| year = pair[0]; result[race] = pair[1].fetch(race); result }
    reading_proficiencies = reading_proficiency.reduce({}) { |result, pair| year = pair[0]; result[race] = pair[1].fetch(race); result }
    writing_proficiencies = writing_proficiency.reduce({}) { |result, pair| year = pair[0]; result[race] = pair[1].fetch(race); result }
    # proficiencies = {
    #   math: :math_proficiency_by_race,
    #   reading: :reading_proficiency_by_race,
    #   writing: :writing_proficiency_by_race
    # }
    #
    # math = proficiencies.fetch(:math)
    # reading = proficiencies.fetch(:reading)
    # writing = proficiencies.fetch(:writing)
    #
    # math_proficiency = @data.fetch(:math_proficiency_by_race)
    # reading_proficiency = @data.fetch(:reading_proficiency_by_race)
    # writing_proficiency = @data.fetch(:writing_proficiency_by_race)
    #
    # math_proficiencies = math_proficiency.reduce({}) { |result, pair| year = pair[0]; result[race] = pair[1].fetch(race); result binding.pry}
    # reading_proficiencies = reading_proficiency.reduce({}) { |result, pair| year = pair[0]; result[race] = pair[1].fetch(race); result }
    # writing_proficiencies = writing_proficiency.reduce({}) { |result, pair| year = pair[0]; result[race] = pair[1].fetch(race); result }
    math = intermediate_math_method_for_race(race)
    reading = intermediate_reading_method_for_race(race)
    writing = intermediate_writing_method_for_race(race)


    combined = math.zip(reading)
    close_hash = combined.map {|first, second| first.zip(second)}.to_h
    almost_there = writing.zip(close_hash.values)
    almost_there
    here = almost_there.last.flatten
    # hi = Hash[here.first, [here[1], here[2], here[3]]]
    # {2011=>0.816, 2012=>0.818, 2013=>0.805, 2014=>0.8}
    # {2011=>0.897, 2012=>0.893, 2013=>0.901, 2014=>0.855}
    # {2011=>0.826, 2012=>0.808, 2013=>0.81, 2014=>0.789}
    # year = pair[0]; result[race] = pair[1].fetch(year); result
    # {:asian =>
    #   { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
    #     2012 => {math: 0.818, reading: 0.893, writing: 0.808},
    #     2013 => {math: 0.805, reading: 0.901, writing: 0.810},
    #     2014 => {math: 0.800, reading: 0.855, writing: 0.789},
    #   }
    # }
  end

  def method_name(race)

  def intermediate_math_method_for_race(race)
    math_data = @data.fetch(:math_proficiency_by_race)
    math_inner_hash = {}
    math_data.each_pair do |key, value|
      math_inner_hash[key] = Hash[:math, value.fetch(race)]
    end
    math_hash = {}
    math_hash[race.to_sym] = math_inner_hash
  end

  def intermediate_reading_method_for_race(race)
    reading_data = @data.fetch(:reading_proficiency_by_race)
    reading_inner_hash = {}
    reading_data.each_pair do |key, value|
      reading_inner_hash[key] = Hash[:reading, value.fetch(race)]
    end
    reading_hash = {}
    reading_hash[race.to_sym] = reading_inner_hash
  end

  def intermediate_writing_method_for_race(race)
    writing_data = @data.fetch(:writing_proficiency_by_race)
    writing_inner_hash = {}
    writing_data.each_pair do |key, value|
      writing_inner_hash[key] = Hash[:writing, value.fetch(race)]
    end
    writing_hash = {}
    writing_hash[race.to_sym] = writing_inner_hash
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
