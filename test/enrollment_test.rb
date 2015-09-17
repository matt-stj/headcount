require_relative '../lib/district_repository'

class EnrollmentTest < Minitest::Test
  def test_online_participation_in_year
    dr = DistrictRepository.from_csv('/Online pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 341, district.enrollment.online_participation_in_year(2013)
  end
end
