class LoadFromCSVS
  attr_reader :statewide_testing, :economic_profile
  RACES_AND_SEXES = { all_students: 'ALL STUDENTS',
                      asian: 'ASIAN STUDENTS',
                      black: 'BLACK STUDENTS',
                      pacific_islander: 'NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER',
                      hispanic: 'HISPANIC STUDENTS',
                      native_american: 'NATIVE AMERICAN STUDENTS',
                      two_or_more: 'TWO OR MORE RACES',
                      white: 'WHITE STUDENTS',
                      male: 'MALE STUDENTS',
                      female: 'FEMALE STUDENTS'
          }

  RACES = { asian: 'ASIAN STUDENTS',
            black: 'BLACK STUDENTS',
            pacific_islander: 'NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER',
            hispanic: 'HISPANIC STUDENTS',
            two_or_more: 'TWO OR MORE RACES',
            white: 'WHITE STUDENTS',
            native_american: 'AMERICAN INDIAN STUDENTS',
            total: 'TOTAL'
          }

  RACES_TWO = { asian: 'ASIAN',
                black: 'BLACK',
                pacific_islander: 'HAWAIIAN/PACIFIC ISLANDER',
                hispanic: 'HISPANIC',
                two_or_more: 'TWO OR MORE',
                white: 'WHITE',
                native_american: 'NATIVE AMERICAN',
                all: 'ALL STUDENTS'
          }
  DATA_TYPES = ['N/A',
                '#VALUE!',
                'LNE',
                "\r\n",
                '0',
                nil
               ]

  def self.path
    File.expand_path '../data', __dir__
  end

  def self.remove_numbers_from_rows(rows)
    rows.delete_if do |row|
      row[:dataformat] == 'Number'
    end
  end

  def self.remove_poverty_levels_from_rows(rows)
    rows.delete_if do |row|
      row[:poverty_level] == 'Eligible for Free Lunch' || row[:poverty_level] == 'Eligible for Reduced Price Lunch'
    end
    end

  def self.group_by(rows)
    rows.group_by { |row| row.fetch(:location) }
  end

  def self.remove_unrecognized_data_from_rows(rows)
    rows.delete_if do |row|
      DATA_TYPES.include?(row[:data])
    end
  end

  def self.district_for(name, repo_data)
    repo_data[name.upcase] ||= {
      enrollment: {
        pupil_enrollment:               {},
        online_enrollment:              {},
        remediation:                    {},
        kindergartner_enrollment:       {},
        special_education:              {},
        graduation_rate:                {},
        dropout_rate_by_race:           {},
        enrollment_by_race:             {}
      },

      statewide_testing: {
        third_grade_proficiency:        {},
        eigth_grade_proficiency:        {},
        math_proficiency_by_race:       {},
        reading_proficiency_by_race:    {},
        writing_proficiency_by_race:    {}
      },

      economic_profile: {
        median_household_income:        {},
        school_aged_childen_in_poverty: {},
        title_one:                      {},
        free_or_reduced_lunch:          {}
      }
    }
  end

  def self.load_pupil_enrollment(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file + '.csv', headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
      district = district_for(district_name, repo_data)
      district[:enrollment][:pupil_enrollment] = data
    end
  end

  def self.load_online_pupil_enrollment(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
      district = district_for(district_name, repo_data)
      district[:enrollment][:online_enrollment] = data
    end
  end

  def self.load_remediation_in_higher_education(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      district = district_for(district_name, repo_data)
      repo_data[district_name.upcase][:enrollment][:remediation] = data
    end
  end

  def self.load_kindergarteners_in_full_day_program(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      district = district_for(district_name, repo_data)
      repo_data[district_name.upcase][:enrollment][:kindergartner_enrollment] = data
    end
  end

  def self.load_special_education(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      district = district_for(district_name, repo_data)
      repo_data[district_name.upcase][:enrollment][:special_education] = data
    end
  end

  def self.load_high_school_graduation_rates(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      district = district_for(district_name, repo_data)
      repo_data[district_name.upcase][:enrollment][:graduation_rate] = data
    end
  end

  def self.load_dropout_rates_by_race(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row| row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by do|row|
        row.fetch(:timeframe).to_i
      end
                       .map do|year, rows|
        [year,
         rows.map do|row|
           [RACES_AND_SEXES.key(row.fetch(:category).upcase),
            row.fetch(:data)[0..4].to_f
           ]
         end.to_h
        ]
      end.to_h
      district = district_for(location, repo_data)
      repo_data[location.upcase][:enrollment][:dropout_rate_by_race] = hash[location]
    end
  end

  def self.load_pupil_enrollment_by_race_ethnicity(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    remove_numbers_from_rows(rows)
    grouped_rows = rows.group_by { |row| row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by do|row|
        row.fetch(:timeframe).to_i
      end
                       .map do|year, rows|
        [year,
         rows.map do|row|
           [RACES.key(row.fetch(:race).upcase),
            row.fetch(:data).to_s[0..4].to_f
           ]
         end.to_h
        ]
      end.to_h
      district = district_for(location, repo_data)
      repo_data[location.upcase][:enrollment][:enrollment_by_race] = hash[location]
    end
  end

  def self.statewide_testing_load_third_grade_students(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    remove_unrecognized_data_from_rows(rows)
    grouped_rows = rows.group_by { |row| row.fetch(:location) }
    # next unless not bullshit (NA, N/A, LNE, #VALUE!, \r\n)
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by do|row|
        row.fetch(:timeframe).to_i
      end
                       .map do|year, rows|
        [year,
         rows.map do|row|
           [row.fetch(:score).downcase.to_sym,
            row.fetch(:data).to_s[0..4].to_f
           ]
         end.to_h
        ]
      end.to_h
      district = district_for(location, repo_data)
      repo_data[location.upcase][:statewide_testing][:third_grade_proficiency] = hash[location]
    end
  end

  def self.statewide_testing_load_eight_grade_students(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    remove_unrecognized_data_from_rows(rows)
    grouped_rows = rows.group_by { |row| row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by do|row|
        row.fetch(:timeframe).to_i
      end
                       .map do|year, rows|
        [year,
         rows.map do|row|
           [row.fetch(:score).downcase.to_sym,
            row.fetch(:data).to_s[0..4].to_f
           ]
         end.to_h
        ]
      end.to_h
      district = district_for(location, repo_data)
      repo_data[location.upcase][:statewide_testing][:eigth_grade_proficiency] = hash[location]
    end
  end

  def self.statewide_testing_load_math_proficiency_by_race(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row| row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by do|row|
        row.fetch(:timeframe).to_i
      end
                       .map do|year, rows|
        [year,
         rows.map do|row|
           [RACES_TWO.key(row.fetch(:race_ethnicity).upcase),
            row.fetch(:data).to_s[0..4].to_f
           ]
         end.to_h
        ]
      end.to_h
      district = district_for(location, repo_data)
      repo_data[location.upcase][:statewide_testing][:math_proficiency_by_race] = hash[location]
    end
  end

  def self.statewide_testing_load_reading_proficiency_by_race(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row| row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by do|row|
        row.fetch(:timeframe).to_i
      end
                       .map do|year, rows|
        [year,
         rows.map do|row|
           [RACES_TWO.key(row.fetch(:race_ethnicity).upcase),
            row.fetch(:data).to_s[0..4].to_f
           ]
         end.to_h
        ]
      end.to_h
      district = district_for(location, repo_data)
      repo_data[location.upcase][:statewide_testing][:reading_proficiency_by_race] = hash[location]
    end
  end

  def self.statewide_testing_load_writing_proficiency_by_race(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row| row.fetch(:location) }
    hash = {}
    location_with_years = grouped_rows.map do |location, rows|
      hash[location] = rows.group_by do|row|
        row.fetch(:timeframe).to_i
      end
                       .map do|year, rows|
        [year,
         rows.map do|row|
           [RACES_TWO.key(row.fetch(:race_ethnicity).upcase),
            row.fetch(:data).to_s[0..4].to_f
           ]
         end.to_h
        ]
      end.to_h
      district = district_for(location, repo_data)
      repo_data[location.upcase][:statewide_testing][:writing_proficiency_by_race] = hash[location]
    end
  end

  def self.load_median_household_income(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe), row.fetch(:data).to_i] }.to_h
      # keys are currently strings as ranges like this "2005-2009"

      district = district_for(district_name, repo_data)
      repo_data[district_name.upcase][:economic_profile][:median_household_income] = data
    end
  end

  def self.load_school_aged_childen_in_poverty(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    remove_numbers_from_rows(rows)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_s[0..4].to_f] }.to_h

      district ||= district_for(district_name, repo_data)
      repo_data[district_name.upcase][:economic_profile][:school_aged_childen_in_poverty] = data
    end
  end

  def self.load_title_one(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_s[0..4].to_f] }.to_h

      district = district_for(district_name, repo_data)
      repo_data[district_name.upcase][:economic_profile][:title_one] = data
    end
  end

  def self.load_free_or_reduced_lunch(path, repo_data, file)
    rows = CSV.readlines(path + '/' + file, headers: true, header_converters: :symbol).map(&:to_h)
    remove_numbers_from_rows(rows)
    remove_poverty_levels_from_rows(rows)
    group_by(rows).each do |district_name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_s[0..4].to_f] }.to_h

      district = district_for(district_name, repo_data)
      repo_data[district_name.upcase][:economic_profile][:free_or_reduced_lunch] = data
    end
  end
end
