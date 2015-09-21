class District
  attr_reader :annual_enrollment, :enrollment, :name, :districts, :online_participation_in_year, :statewide_testing
  def initialize(data)
    data = data
      @enrollment = Enrollment.new(data.fetch :enrollment)
  end

  def name(name)
    @name
  end

end
