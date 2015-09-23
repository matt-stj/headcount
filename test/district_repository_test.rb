require_relative '../lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
  attr_reader :path

  def path
    File.expand_path '../data', __dir__
  end

  def make_a_dr
    @dr ||= DistrictRepository.from_csv(path)
  end

  def test_it_can_load_a_district_from_csv_data
    make_a_dr
    district = @dr.find_by_name('ACADEMY 20')
    assert_equal 22_620, district.enrollment.in_year(2009)
    assert_equal 0.895, district.enrollment.graduation_rate_in_year(2010)
  end

  def test_enrollment_data_with_NA_values_return_zero
    make_a_dr
    district = @dr.find_by_name('WEST YUMA COUNTY RJ-1')

    assert_equal 0, district.enrollment.in_year(2014)
  end

  def test_it_works_for_other_things
    make_a_dr
    district = @dr.find_by_name('COLORADO')

    assert_equal 863_561, district.enrollment.in_year(2012)
  end

  def test_the_district_repo_is_complete_with_all_181_districts
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    districts = dr.districts

    assert_equal 181, districts.size
  end
end
