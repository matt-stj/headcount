require_relative '../lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
  attr_reader :path

  def test_it_can_load_a_district_from_csv_data
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")
    assert_equal 22620, district.enrollment.in_year(2009)
    assert_equal 0.895, district.enrollment.graduation_rate_in_year(2010)
    # assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_enrollment_data_with_NA_values_return_zero
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("WEST YUMA COUNTY RJ-1")

    assert_equal 0, district.enrollment.in_year(2014)
  end

  def test_it_works_for_other_things
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("COLORADO")

    assert_equal 863561, district.enrollment.in_year(2012)
  end

  def test_the_district_repo_is_complete_with_all_181_districts
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    districts = dr.districts

    assert_equal 181, districts.size
  end
end
