class District
  attr_reader :annual_enrollment, :enrollment, :name, :districts, :online_participation_in_year
  def initialize(data)
    data = data
    if data.key? :enrollment # TODO: once all ways of instantiating are moved over to use the enrollment key, then don't check this
      @enrollment = Enrollment.new(data.fetch :enrollment)
    else
      @enrollment = Enrollment.new(data)
    end
    @statewide_testing = StatewideTesting.new(data)
  end

  def name(name)
    @name
  end

end
