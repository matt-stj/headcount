require 'csv'
require 'pry'

class DistrictRepository
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


  def self.from_csv(file)
    if file == '/Online pupil enrollment.csv'
      load_online_pupil_enrollment
      DistrictRepository.new(@online_enrollment_pupil_repo)
    elsif file == '/Pupil enrollment.csv'
      load_pupil_enrollment
      DistrictRepository.new(@enrollment_pupil_repo)
    end
  end

  def initialize(repository_data)
    @districts = repository_data.map { |name, district_data|
      [name, District.new(district_data)]}.to_h
  end

  def find_by_name(name)
    if !@districts.has_key?(name) == true
      return nil
    else
      @districts.fetch(name)
    end
  end

  def name(name)
    if @districts.has_key?(name.upcase)
      return name.upcase
    end
  end

end

class District
  attr_reader :annual_enrollment, :enrollment, :name, :districts, :online_participation_in_year
  def initialize(data)
    data = data
    @enrollment = Enrollment.new(data)
  end

  def name(name)
    @name
  end

end

class Enrollment
  attr_reader :annual_enrollment, :enrollment

  def initialize(data)
    @data = data
  end


  def in_year(year)
    @data.fetch(year)
  end

  def online_participation_in_year(year)
    @data.fetch(year)
  end
end
