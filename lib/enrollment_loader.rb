require_relative 'statewide_loader'

class EnrollmentLoader
  RACES_AND_SEXES = { :all_students => "ALL STUDENTS",
            :asian=>"ASIAN STUDENTS",
            :black=>"BLACK STUDENTS",
            :pacific_islander=>"NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER",
            :hispanic=>"HISPANIC STUDENTS",
            :native_american=>"NATIVE AMERICAN STUDENTS",
            :two_or_more=>"TWO OR MORE RACES",
            :white => "WHITE STUDENTS",
            :male => "MALE STUDENTS",
            :female => "FEMALE STUDENTS"
          }

  RACES = {:asian=>"ASIAN STUDENTS",
          :black=>"BLACK STUDENTS",
          :pacific_islander=>"NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER",
          :hispanic=>"HISPANIC STUDENTS",
          :two_or_more=>"TWO OR MORE RACES",
          :white => "WHITE STUDENTS",
          :native_american => "AMERICAN INDIAN STUDENTS",
          :total => "TOTAL"
          }

  def self.path
    File.expand_path '../data', __dir__
  end

  def self.remove_numbers_from_rows(rows)
    rows.delete_if do |row|
      row[:dataformat] == 'Number'
    end
  end

  def self.group_by(rows)
    rows.group_by { |row| row.fetch(:location) }
  end

  def self.data_format_checker(rows)
    formats = rows.map {|row| row.fetch(:dataformat) }
    formats.uniq!
  end

  def self.load_pupil_enrollment(path, repo_data)
    rows = CSV.readlines(path + '/Pupil enrollment.csv', headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
      repo_data[district_name.upcase] ||= {enrollment: {pupil_enrollment: {}}}
      repo_data[district_name.upcase][:enrollment][:pupil_enrollment] = data
    end
  end

  def self.load_online_pupil_enrollment(path, repo_data)
    rows = CSV.readlines(path + '/Online pupil enrollment.csv', headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
      repo_data[district_name.upcase] ||= {enrollment: {online_enrollment: {}}}
      repo_data[district_name.upcase][:enrollment][:online_enrollment] = data
    end
  end

  def self.load_remediation_in_higher_education(path, repo_data)
    rows = CSV.readlines(path + '/Remediation in higher education.csv', headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      repo_data[district_name.upcase] ||= {enrollment: {remediation: {}}}
      repo_data[district_name.upcase][:enrollment][:remediation] = data
    end
  end

  def self.load_kindergarteners_in_full_day_program(path, repo_data)
    rows = CSV.readlines(path + '/Kindergartners in full-day program.csv', headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      repo_data[district_name.upcase] ||= {enrollment: {kindergartner_enrollment: {}}}
      repo_data[district_name.upcase][:enrollment][:kindergartner_enrollment] = data
    end
  end

  def self.load_special_education(path, repo_data)
    rows = CSV.readlines(path + '/Special education.csv', headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
    data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
    repo_data[district_name.upcase] ||= {enrollment: {special_education: {}}}
    repo_data[district_name.upcase][:enrollment][:special_education] = data
    end
  end

  def self.load_high_school_graduation_rates(path, repo_data)
    rows = CSV.readlines(path + '/High school graduation rates.csv', headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      repo_data[district_name.upcase] ||= {enrollment: {graduation_rate: {}}}
      repo_data[district_name.upcase][:enrollment][:graduation_rate] = data
    end
  end

  def self.load_dropout_rates_by_race(path, repo_data)
    rows = CSV.readlines(path + '/Dropout rates by race and ethnicity.csv', headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row|  row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by {|row|
        row.fetch(:timeframe).to_i
      }
      .map {|year, rows|
        [year,
          rows.map {|row|
            [ RACES_AND_SEXES.key(row.fetch(:category).upcase),
              row.fetch(:data)[0..4].to_f
            ]
          }.to_h
        ]
      }.to_h
      repo_data[location.upcase] ||= {enrollment: {dropout_rate_by_race: {}}}
      repo_data[location.upcase][:enrollment][:dropout_rate_by_race] = hash[location]
    end
  end

  def self.load_pupil_enrollment_by_race_ethnicity(path, repo_data)
    rows = CSV.readlines(path + '/Pupil enrollment by race_ethnicity.csv', headers: true, header_converters: :symbol).map(&:to_h)
    remove_numbers_from_rows(rows)
    grouped_rows = rows.group_by { |row|  row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by {|row|
        row.fetch(:timeframe).to_i
      }
      .map {|year, rows|
        [year,
          rows.map {|row|
            [ RACES.key(row.fetch(:race).upcase),
              row.fetch(:data).to_s[0..4].to_f
            ]
          }.to_h
        ]
      }.to_h
      repo_data[location.upcase] ||= {enrollment: {enrollment_by_race: {}}}
      repo_data[location.upcase][:enrollment][:enrollment_by_race] = hash[location]
    end
  end

  ####### Begin STATEWIDE ----------------------


  def self.statewide_testing_load_third_grade_students(path, repo_data)
    rows = CSV.readlines(path + '/3rd grade students scoring proficient or above on the CSAP_TCAP.csv', headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row| row.fetch(:location)}
    # next unless not bullshit (NA, N/A, LNE, #VALUE!, \r\n)
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by {|row|
        row.fetch(:timeframe).to_i
      }
      .map {|year, rows|
        [year,
          rows.map {|row|
            [ row.fetch(:score).downcase.to_sym,
              row.fetch(:data).to_s[0..4].to_f
            ]
          }.to_h
        ]
      }.to_h
      repo_data[location.upcase] ||= {enrollment: {third_grade_proficiency: {}}}
      repo_data[location.upcase][:enrollment][:third_grade_proficiency] = hash[location]
    end
  end

  def self.statewide_testing_load_eight_grade_students(path, repo_data)
    rows = CSV.readlines(path + '/8th grade students scoring proficient or above on the CSAP_TCAP.csv', headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row| row.fetch(:location)}
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by {|row|
        row.fetch(:timeframe).to_i
      }
      .map {|year, rows|
        [year,
          rows.map {|row|
            [ row.fetch(:score).downcase.to_sym,
              row.fetch(:data).to_s[0..4].to_f
            ]
          }.to_h
        ]
      }.to_h
      repo_data[location.upcase] ||= {enrollment: {eigth_grade_proficiency: {}}}
      repo_data[location.upcase][:enrollment][:eigth_grade_proficiency] = hash[location]
    end
  end

    def self.statewide_testing_load_math_proficiency_by_race(path, repo_data)
      rows = CSV.readlines(path + '/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv', headers: true, header_converters: :symbol).map(&:to_h)
      grouped_rows = rows.group_by { |row| row.fetch(:location)}
      hash = {}
      location_with_years = grouped_rows.map do |location, rows|
        hash[location] = rows.group_by {|row|
          row.fetch(:timeframe).to_i
        }
        .map {|year, rows|
          [year,
            rows.map {|row|
              [ row.fetch(:race_ethnicity).downcase.to_sym,
                row.fetch(:data).to_s[0..4].to_f
              ]
            }.to_h
          ]
        }.to_h
        repo_data[location.upcase] ||= {enrollment: {math_proficiency_by_race: {}}}
        repo_data[location.upcase][:enrollment][:math_proficiency_by_race] = hash[location]
      end
    end

    def self.statewide_testing_load_reading_proficiency_by_race(path, repo_data)
      rows = CSV.readlines(path + '/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv', headers: true, header_converters: :symbol).map(&:to_h)
      grouped_rows = rows.group_by { |row| row.fetch(:location)}
      hash = {}
      location_with_years = grouped_rows.map do |location, rows|
        hash[location] = rows.group_by {|row|
          row.fetch(:timeframe).to_i
        }
        .map {|year, rows|
          [year,
            rows.map {|row|
              [ row.fetch(:race_ethnicity).downcase.to_sym,
                row.fetch(:data).to_s[0..4].to_f
              ]
            }.to_h
          ]
        }.to_h
        repo_data[location.upcase] ||= {enrollment: {reading_proficiency_by_race: {}}}
        repo_data[location.upcase][:enrollment][:reading_proficiency_by_race] = hash[location]
      end
    end

    def self.statewide_testing_load_writing_proficiency_by_race(path, repo_data)
      rows = CSV.readlines(path + '/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv', headers: true, header_converters: :symbol).map(&:to_h)
      grouped_rows = rows.group_by { |row| row.fetch(:location)}
      hash = {}
      location_with_years = grouped_rows.map do |location, rows|
        hash[location] = rows.group_by {|row|
          row.fetch(:timeframe).to_i
        }
        .map {|year, rows|
          [year,
            rows.map {|row|
              [ row.fetch(:race_ethnicity).downcase.to_sym,
                row.fetch(:data).to_s[0..4].to_f
              ]
            }.to_h
          ]
        }.to_h
        repo_data[location.upcase] ||= {enrollment: {writing_proficiency_by_race: {}}}
        repo_data[location.upcase][:enrollment][:writing_proficiency_by_race] = hash[location]
      end
    end

    #trying to load in a way to group by race
    # def self.statewide_testing_load_writing_proficiency_by_race_for_all(path, repo_data)
    #   rows = CSV.readlines(path + '/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv', headers: true, header_converters: :symbol).map(&:to_h)
    #   grouped_rows = rows.group_by { |row| row.fetch(:location)}
    #   hash = {}
    #   location_with_years = grouped_rows.map do |location, rows|
    #     hash[location] = rows.group_by {|row|
    #       row.fetch(:race_ethnicity).downcase.to_sym
    #     }
    #     .map {|year, rows|
    #       [year,
    #         rows.map {|row|
    #           [ row.fetch(:timeframe).to_i,
    #             row.fetch(:data).to_s[0..4].to_f
    #           ]
    #         }.to_h
    #       ]
    #     }.to_h
    #
    #     repo_data[location.upcase] ||= {enrollment: {writing_proficiency_by_race_for_all: {}}}
    #     repo_data[location.upcase][:enrollment]([:writing_proficiency_by_race_for_all][:writing] = hash[location]
    #     binding.pry
    #   end
    # end

    # END STATEWIDE ----------------------

    # BEGINECONOMIC PROFILE -------------

    def self.load_median_household_income(path, repo_data)
      rows = CSV.readlines(path + '/Median household income.csv', headers: true, header_converters: :symbol).map(&:to_h)
      group_by(rows).each do |district_name, rows|
        data = rows.map { |row| [row.fetch(:timeframe), row.fetch(:data).to_i] }.to_h
        #keys are currently strings as ranges like this "2005-2009"

        repo_data[district_name.upcase] ||= {enrollment: {median_household_income: {}}}
        repo_data[district_name.upcase][:enrollment][:median_household_income] = data
      end
    end

    def self.school_aged_childen_in_poverty(path, repo_data)
      rows = CSV.readlines(path + '/School-aged children in poverty.csv', headers: true, header_converters: :symbol).map(&:to_h)
      remove_numbers_from_rows(rows)
      group_by(rows).each do |district_name, rows|
        data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_s[0..4].to_f] }.to_h


        #needs to work for numbers and percents

        repo_data[district_name.upcase] ||= {enrollment: {school_aged_childen_in_poverty: {}}}
        repo_data[district_name.upcase][:enrollment][:school_aged_childen_in_poverty] = data
      end
    end

    ## need free or reducd lunch
    def self.load_title_one(path, repo_data)
      rows = CSV.readlines(path + '/Title I students.csv', headers: true, header_converters: :symbol).map(&:to_h)
      group_by(rows).each do |district_name, rows|
        data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_s[0..4].to_f] }.to_h

        repo_data[district_name.upcase] ||= {enrollment: {title_one: {}}}
        repo_data[district_name.upcase][:enrollment][:title_one] = data
      end
    end



end
