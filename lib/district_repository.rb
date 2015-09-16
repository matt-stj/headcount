require_relative './district'
require_relative 'parser'

class DistrictRepository
  #returns a District Repository
  def self.from_csv(data_dir)
    enrollment_data = EnrollmentLoader.new(data_dir)
    pupil_enrollment_loader
    #give some structure that we parsed from csv
  end

  # should return instance of District
  def find_by_name(name)
    self.select {|d| d.fetch(:location) == name }
  end

  # reutns an instance of Enrollment
  def enrollment
    Enrollment.new
  end

  # def find_by_name(name)
  #   @districts.select { |d| name: name }
  # end

  # def self.from_csv(data_dir)
  #   # processed_data = Parser.process_data(data_dir)
  #
  #   # build the file path
  #   # iterate through each file, and open it
  #     # for each file
  #       # process the csv data.
  #       # do something with each row of data. (convert strings to i)
  #
  #   DistrictRepository.new(processed_data)
  # end

  # def initialize(data_from_csv)
  #   # take csv data:
  #   # for each district represented,
  #     # make a new District object
  #       #district =  District.new(formatted_district_data)
  #     #collect all the districts
  #   @districts = [] #  [#district id:1, distirct id: 2]
  # end

end


data_dir = '/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data'
DistrictRepository.from_csv(data_dir)
