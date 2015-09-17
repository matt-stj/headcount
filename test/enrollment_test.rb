require_relative '../lib/district_repository'
require 'pry'

class EnrollmentTest < Minitest::Test
  def test_online_participation_in_year
    dr = DistrictRepository.from_csv('/Online pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 341, district.enrollment.online_participation_in_year(2013)
  end

  def test_graduation_rate_in_year
    dr = DistrictRepository.from_csv('/High school graduation rates.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.895, district.enrollment.graduation_rate_in_year(2010)
  end

  def test_edge_case_truncate_floats
    dr = DistrictRepository.from_csv('/High school graduation rates.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.889, district.enrollment.graduation_rate_in_year(2012)
  end
end
