class EnrollmentLoader
  attr_reader :path, :districts, :name, :online_enrollment_pupil_repo

  def self.path
    File.expand_path '../data', __dir__
  end

  def self.load_pupil_enrollment
    rows = CSV.readlines(path + '/Pupil enrollment.csv', headers: true, header_converters: :symbol).map(&:to_h)
    groups = rows.group_by { |row| row.fetch(:location) }
    enrollment_data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    @enrollment_pupil_repo = {}
    groups.each_pair do |key, value|
      @enrollment_pupil_repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    end
  end

  def self.load_online_pupil_enrollment
    rows = CSV.readlines(path + '/Online pupil enrollment.csv', headers: true, header_converters: :symbol).map(&:to_h)
    groups = rows.group_by { |row| row.fetch(:location) }
    enrollment_data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    @online_enrollment_pupil_repo = {}
    groups.each_pair do |key, value|
      @online_enrollment_pupil_repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    end
  end
end
