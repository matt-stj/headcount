require_relative 'economic_data'

class District
  attr_reader :annual_enrollment, :enrollment, :name, :districts, :online_participation_in_year, :statewide_testing, :economic_data
  def initialize(name, data)
    data = data
    @name = name
    @enrollment = Enrollment.new(data.fetch :enrollment)
    @statewide_testing = StatewideTesting.new(data.fetch :statewide_testing)
    @economic_data = EconomicData.new(data.fetch :economic_data)
  end


end
