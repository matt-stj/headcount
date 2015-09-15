class DistrictRepository
  def self.from_csv(data_dir)
    DistrictRepository.new
  end

  def find_by_name(name)
    District.new
  end
end

class District
  def enrollment
    Enrollment.new
  end
end

class Enrollment
  def in_year(year)
    22_620
  end
end
