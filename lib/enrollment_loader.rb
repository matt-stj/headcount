require_relative 'statewide_loader'

class EnrollmentLoader
  def self.path
    File.expand_path '../data', __dir__
  end

  def self.group_by(rows)
    rows.group_by { |row| row.fetch(:location) }
  end

  def self.data_format_checker(rows)
    formats = rows.map {|row| row.fetch(:dataformat) }
    formats.uniq!
  end

  def self.repo_builder(repo, groups, data_type = :integer)
    if data_type == :float
      groups.each_pair do |key, value|
        repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      end
    else
      groups.each_pair do |key, value|
        repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
      end
                          #WHAT DATA REPRESENTS (:online_pupil)
    end
  end

  def self.repo_builder_extreme(repo, groups, data_type = :float)
    groups.each_pair do |key, value|
      repo[key.upcase] = value.map { |row| Hash[row.fetch(:timeframe).to_i => [row.fetch(:race).to_sym, row.fetch(:data)].flatten].to_h}
    end
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

  def self.drop_out_builder(repo, groups)
      groups.each_pair do |key, value|
        repo[key] ||= Hash[value.map { |row| [[[:year => row.fetch(:timeframe).to_i], [:data => row.fetch(:data)[0..4].to_f], [:category => row.fetch(:category)]]] }.compact]
    end
  end

  def self.load_dropout_rates_by_race
    rows = CSV.readlines(path + '/Dropout rates by race and ethnicity.csv', headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row|  row.fetch(:location).upcase }
    @enrollment_dropout_by_race_repo = {}
    location_with_years = grouped_rows.map do |key, value|
     @enrollment_dropout_by_race_repo[key] ||= value.map {|row| [row.fetch(:timeframe).to_i, value.map {|row| [row.fetch(:category).downcase, row.fetch(:data)[0..4].to_f]}.to_h]}.to_h
    end
    @enrollment_dropout_by_race_repo

    # drop_out_builder(@enrollment_dropout_by_race_repo, groups)
  end

  def self.convert_keys_to_correct_symbols(repo)

  end

  # def self.sped_repo_builder(repo, groups)
  #     groups.each_pair do |key, value|
  #       if groups.fetch(:dataformat) == "Percent"
  #       repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
  #     else
  #         repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
  #     end
  #   end
  # end
  #
  # def self.load_special_education
  #   rows = CSV.readlines(path + '/Special education.csv', headers: true, header_converters: :symbol).map(&:to_h)
  #   groups = rows.group_by { |row| row.fetch(:location) }
  #   binding.pry
  #   @enrollment_special_education_repo = {}
  #   sped_repo_builder(@enrollment_special_education_repo, groups)
  #   binding.pry
  # end
  # load_special_education



  # def self.load_pupil_enrollment_by_race_ethnicity
  #   rows = CSV.readlines(path + '/Pupil enrollment by race_ethnicity.csv', headers: true, header_converters: :symbol).map(&:to_h)
  #   groups = group_by(rows)
  #   @pupil_enrollment_race_ethnicity_repo = {}
  #   repo_builder_extreme(@pupil_enrollment_race_ethnicity_repo, groups, :float)
  # end
end
