require_relative '../lib/headcount'

class TestLoadingDistricts < Minitest::Test
  def data_dir
    File.expand_path '../data', __dir__
  end

  def test_it_can_load_a_district_from_csv_data
    dr = DistrictRepository.from_csv(data_dir)
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 22620, district.enrollment.in_year(2009)
    # assert_equal 0.895, district.enrollment.graduation_rate.for_high_school_in_year(2010)
    # assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end
end

# district.enrollment.in_year(2009) # => 22620
# district.enrollment.graduation_rate.for_high_school_in_year(2010) # => 0.895
# district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008) # => 0.857
