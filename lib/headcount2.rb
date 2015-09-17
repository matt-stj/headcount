require 'csv'

class DistrictRepository
  attr_reader :path, :districts, :name

  def self.path
    File.expand_path '../data', __dir__
  end

  def self.from_csv(file)
    rows = CSV.readlines(path + '/Pupil enrollment.csv', headers: true, header_converters: :symbol).map(&:to_h)
    groups = rows.group_by { |row| row.fetch(:location) }
    enrollment_data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    @enrollment_pupil_repo = {}
    groups.each_pair do |key, value|
      @enrollment_pupil_repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    end
    @enrollment_pupil_repo
    DistrictRepository.new(@enrollment_pupil_repo)
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

end

class District
  attr_reader :annual_enrollment, :enrollment, :name, :districts
  def initialize(data)
    data = data
    @enrollment = Enrollment.new(data)
  end

  def enrollment
    @enrollment
  end

  def name(the_name)
    @districts
  end

end

class Enrollment
  attr_reader :annual_enrollment

  def initialize(data)
    @annual_enrollment = data
  end

  def enrollment
    @enrollment
  end

  def in_year(year)
    annual_enrollment.fetch(year)
  end
end
#
# dr = DistrictRepository.from_csv('/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data/Pupil enrollment.csv')
# district = dr.find_by_name("COLORADO")
# district.enrollment.class
# # => Enrollment
