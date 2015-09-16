class DistrictRepository
  def self.from_csv(data_dir)
    DistrictRepository.new
  end

  def find_by_name(name)
    District.new
  end
end
