require_relative 'economic_profile'

class District
  attr_reader :annual_enrollment, :enrollment, :name, :districts, :online_participation_in_year, :statewide_testing, :economic_profile
  def initialize(name, data)
    data = data
    @name = name
    @enrollment = Enrollment.new(data.fetch :enrollment)
    @statewide_testing = StatewideTesting.new(data.fetch :statewide_testing)
    @economic_profile = EconomicProfile.new(data.fetch :economic_profile)
  end

end
