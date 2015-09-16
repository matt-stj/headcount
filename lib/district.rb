require_relative 'enrollment'
require_relative 'district_repository'
require 'csv'

class District
  def enrollment
    Enrollment.new
  end
end

District.new

# dr = District.new.pupil_enrollment_loader
# district = dr.select {|hash| hash.fetch(:location) == "ACADEMY 20" }
# district.class

# data = district.select { |hash| hash.fetch(:timeframe) == "2009" }.first[:data]
