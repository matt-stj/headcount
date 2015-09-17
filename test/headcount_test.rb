require_relative '../lib/headcount2'

class TestLoadingDistricts < Minitest::Test
  attr_reader :path

  # Acceptance Test
  def test_it_can_load_a_district_from_csv_data
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 22620, district.enrollment.in_year(2009)
    # assert_equal 0.895, district.enrollment.graduation_rate.for_high_school_in_year(2010)
    # assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  # District Test
  def test_find_by_name_returns_an_instance_of_district_if_successful
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal District, district.class
  end

  #District Test
  def test_find_by_name_returns_nil_if_unsuccessful
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 201")

    assert_equal nil, district
  end

  # District_Repo_Test
  def test_enrollment_data_with_NA_values_return_zero
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("WEST YUMA COUNTY RJ-1")

    assert_equal 0, district.enrollment.in_year(2014)
  end

  #District_Repo_Test
  def test_it_works_for_other_things
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("COLORADO")

    assert_equal 863561, district.enrollment.in_year(2012)
  end

  #District_Repo_Test
  def test_the_district_repo_is_full
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    districts = dr.districts

    assert_equal 181, districts.size
  end

  # District_Test
  def test_calling_enrollment_on_a_district_returns_and_instance_of_Enrollment
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("COLORADO")

    assert_equal Enrollment, district.enrollment.class
  end

  def test_calling_name_on_District_returns_the_upcased_name_of_the_District
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')

    assert_equal "COLORADO", dr.name("Colorado")
  end

end

# district.enrollment.in_year(2009) # => 22620
# district.enrollment.graduation_rate.for_high_school_in_year(2010) # => 0.895
# district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008) # => 0.857
