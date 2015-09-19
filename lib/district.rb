class District
  attr_reader :annual_enrollment, :enrollment, :name, :districts, :online_participation_in_year
  def initialize(data)
    data = data
    @enrollment = Enrollment.new(data)
    @statewide_testing = StatewideTesting.new(data)
  end

  def name(name)
    @name
  end

end
