require_relative '../lib/district_repository'

class DistrictTest < Minitest::Test

  def test_find_by_name_returns_an_instance_of_district_if_successful
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal District, district.class
  end

  def test_find_by_name_returns_nil_if_unsuccessful
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 201")

    assert_equal nil, district
  end

  def test_calling_enrollment_on_a_district_returns_and_instance_of_Enrollment
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("COLORADO")

    assert_equal Enrollment, district.enrollment.class
  end

  def test_calling_name_on_District_returns_the_upcased_name_of_the_District
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')

    assert_equal "COLORADO", dr.find_by_name("Colorado").name
  end
end
