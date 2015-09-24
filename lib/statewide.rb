class UnknownDataError < StandardError
end

class StatewideTesting
  POSSIBLE_RACES = [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
  POSSIBLE_SUBJECTS = [:reading, :writing, :math]
  POSSIBLE_YEARS = [2011, 2012, 2013, 2014]

  attr_reader :statewide_testing, :data, :remove_bullshit

  def initialize(data)
    @data = data
  end

  def proficient_by_grade(grade)
    if grade == 3
      third_grade = @data.fetch(:third_grade_proficiency, UnknownDataError)
      third_grade.map {|key, value| key = key, value = value.reject {|key, value| value == nil}}.to_h
    elsif grade == 8
      eigth_grade = @data.fetch(:eigth_grade_proficiency, UnknownDataError)
      eigth_grade.map {|key, value| key = key, value = value.reject {|key, value| value == nil}}.to_h
    else
      # #not sure if we still need this becuase of the argumet above
      fail UnknownDataError
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if subject == :math || subject == :reading || subject == :writing
      grade_data = proficient_by_grade(grade)
    else
      fail UnknownDataError
    end
    if grade_data.key?(year)
      grade_data.fetch(year).fetch(subject)
    else
      fail UnknownDataError
    end
  end

  def proficient_for_subject_in_year(subject, year)
    if subject == :math
      math_data = @data.fetch(:math_proficiency_by_race)
      if math_data.key?(year)
        math_data.fetch(year).fetch(:all)
      else
        fail UnknownDataError
      end
      # Need to refactor for this to be shorter and for the bottom two cases to raise the same error as above.
    elsif subject == :reading
      @data.fetch(:reading_proficiency_by_race).fetch(year, UnknownDataError).fetch(:all)
    elsif subject == :writing
      @data.fetch(:writing_proficiency_by_race).fetch(year, UnknownDataError).fetch(:all)
    else
      fail UnknownDataError
    end
  end

  def proficient_by_race_or_ethnicity(race)
    if POSSIBLE_RACES.include?(race)
      math = intermediate_math_method_for_race(race)
      reading = intermediate_reading_method_for_race(race)
      writing = intermediate_writing_method_for_race(race)

      years = (math.keys + reading.keys + writing.keys).uniq.sort
      years_to_scores = years.map do |year|
        scores = { math:    math.fetch(year).fetch(:math),
                   reading: reading.fetch(year).fetch(:reading),
                   writing: writing.fetch(year).fetch(:writing)
        }
        [year, scores]
      end.to_h
    else
      fail UnknownDataError
     end
   end

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
    if POSSIBLE_RACES.include?(race) && POSSIBLE_SUBJECTS.include?(subject) && POSSIBLE_YEARS.include?(year)
      proficiencies = {
        math: :math_proficiency_by_race,
        reading: :reading_proficiency_by_race,
        writing: :writing_proficiency_by_race
      }
      proficiency = proficiencies.fetch(subject)
      @data.fetch(proficiency).fetch(year).fetch(race)
    else
      fail UnknownDataError
     end
  end

  def statewide_combining_proficienty_by_race_and_subject(_race)
    years_and_all_data_math = @data.fetch(:math_proficiency_by_race)
    years_and_all_data_reading = @data.fetch(:reading_proficiency_by_race)
    years_and_all_data_writing = @data.fetch(:writing_proficiency_by_race)
  end
end
