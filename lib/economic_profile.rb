class UnknownDataError < StandardError
end

class EconomicProfile
  attr_reader :economic_profile

  def initialize(data)
    @data = data
  end

  def free_or_reduced_lunch_by_year
    @data.fetch(:free_or_reduced_lunch)
  end

  def free_or_reduced_lunch_in_year(year)
    data = @data.fetch(:free_or_reduced_lunch)
    if data.has_key?(year)
      free_or_reduced_lunch_by_year.fetch(year)
    else
      nil
    end
  end

  def school_aged_children_in_poverty_by_year
    @data.fetch(:school_aged_childen_in_poverty)
  end

  def school_aged_children_in_poverty_in_year(year)
    data = @data.fetch(:school_aged_childen_in_poverty)
    if data.has_key?(year)
      school_aged_children_in_poverty_by_year.fetch(year)
    else
      nil
    end
  end

  def title_1_students_by_year
    @data.fetch(:title_one)
  end

  def title_1_students_in_year(year)
    data = @data.fetch(:title_one)
    if data.has_key?(year)
      title_1_students_by_year.fetch(year)
    else
      nil
    end
  end
end
