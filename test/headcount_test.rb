<<<<<<< HEAD
require_relative '../lib/district'
=======
require_relative '../lib/headcount2'
>>>>>>> matts_stuff

class TestLoadingDistricts < Minitest::Test
  def path
    File.expand_path '../data', __dir__
  end

  # def test_it_can_load_a_csv
  # end
  #
  # def test_it_can_load_the_csvs(data_dir)
  #   skip
  #   dr = DistrictRepository.from_csv(data_dir)
  #   # assert that dr is an array of districts objects
  #   # assert teh expected number of items in the array
  #   # dr.districts
  # end

  # def test_it_can_find_by_name
  #   skip
  # end

  def test_it_can_load_a_district_from_csv_data
    dr = DistrictRepository.from_csv(path)
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 22620, district.enrollment.in_year(2009)
    # assert_equal 0.895, district.enrollment.graduation_rate.for_high_school_in_year(2010)
    # assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_can_do_things
    dr = DistrictRepository.from_csv(path)
    district = dr.find_by_name("WEST YUMA COUNTY RJ-1")

    assert_equal 0, district.enrollment.in_year(2014)
  end

  def test_it_works_for_other_things
    dr = DistrictRepository.from_csv(path)
    district = dr.find_by_name("COLORADO")

    assert_equal 863561, district.enrollment.in_year(2012)
  end
end


# # district
# def test_it_has_an_enrollment
# end
#
# #enrollment
# def test_it_has_an_in_year_attribute
# end





# district.enrollment.in_year(2009) # => 22620
# district.enrollment.graduation_rate.for_high_school_in_year(2010) # => 0.895
# district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008) # => 0.857
