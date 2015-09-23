require_relative '../lib/district_repository'

class StatewideTestingTest < Minitest::Test
  def path
    File.expand_path '../data', __dir__
  end

  def make_a_dr
    @dr ||= DistrictRepository.from_csv(path)
  end

  def test_proficient_for_subject_by_race_in_year
    make_a_dr
    colorado = @dr.find_by_name('COLORADO')

    assert_equal 0.656, colorado.statewide_testing.proficient_for_subject_by_race_in_year(:writing, :asian, 2011)
    assert_raises(UnknownDataError) { colorado.statewide_testing.proficient_for_subject_by_race_in_year(:science, :asian, 2011) }
    assert_raises(UnknownDataError) { colorado.statewide_testing.proficient_for_subject_by_race_in_year(:reading, :barbarian, 2011) }
  end

  def test_proficient_by_grade_third_grade
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')

    expected_result = { 2008 => { math: 0.857, reading: 0.866, writing: 0.671 },
                        2009 => { math: 0.824, reading: 0.862, writing: 0.706 },
                        2010 => { math: 0.849, reading: 0.864, writing: 0.662 },
                        2011 => { math: 0.819, reading: 0.867, writing: 0.678 },
                        2012 => { reading: 0.87, math: 0.83, writing: 0.655 },
                        2013 => { math: 0.855, reading: 0.859, writing: 0.668 },
                        2014 => { math: 0.834, reading: 0.831, writing: 0.639 } }

    # should be district.statewide.proficient_by_grade(grade)
    assert_raises(UnknownDataError) { academy_20.statewide_testing.proficient_by_grade(10) }
    assert_equal expected_result, academy_20.statewide_testing.proficient_by_grade(3)
  end

  def test_proficient_by_grade_eigth_grade
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    expected_result = { 2008 => { math: 0.64, reading: 0.843, writing: 0.734 },
                        2009 => { math: 0.656, reading: 0.825, writing: 0.701 },
                        2010 => { math: 0.672, reading: 0.863, writing: 0.754 },
                        2011 => { reading: 0.832, math: 0.653, writing: 0.745 },
                        2012 => { math: 0.681, writing: 0.738, reading: 0.833 },
                        2013 => { math: 0.661, reading: 0.852, writing: 0.75 },
                        2014 => { math: 0.684, reading: 0.827, writing: 0.747 } }

    # should be district.statewide.proficient_by_grade(grade)
    assert_raises(UnknownDataError) { academy_20.statewide_testing.proficient_by_grade(10) }
    assert_equal expected_result, academy_20.statewide_testing.proficient_by_grade(8)
  end

  def test_proficient_for_subject_in_year
    make_a_dr
    dr = @dr
    academy_20 = dr.find_by_name('ACADEMY 20')

    assert_equal 0.680, academy_20.statewide_testing.proficient_for_subject_in_year(:math, 2011)
    assert_equal 0.845, academy_20.statewide_testing.proficient_for_subject_in_year(:reading, 2012)
    assert_equal 0.720, academy_20.statewide_testing.proficient_for_subject_in_year(:writing, 2013)
    assert_raises(UnknownDataError) { academy_20.statewide_testing.proficient_for_subject_in_year(:cooking, 2013) }
    assert_raises(UnknownDataError) { academy_20.statewide_testing.proficient_for_subject_in_year(:math, 2010) }
  end

  def test_proficient_for_subject_by_grade_eigth_grade
    make_a_dr
    dr = @dr
    academy_20 = dr.find_by_name('ACADEMY 20')
    # should be district.statewide.method_name
    assert_equal 0.681, academy_20.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 8, 2012)
    assert_raises(UnknownDataError) { academy_20.statewide_testing.proficient_for_subject_by_grade_in_year(:science, 8, 2012) }
    assert_raises(UnknownDataError) { academy_20.statewide_testing.proficient_for_subject_by_grade_in_year(:science, 14, 2012) }
    assert_raises(UnknownDataError) { academy_20.statewide_testing.proficient_for_subject_by_grade_in_year(:science, 8, 1234) }
    assert_equal 0.747, academy_20.statewide_testing.proficient_for_subject_by_grade_in_year(:writing, 8, 2014)
    assert_equal 0.832, academy_20.statewide_testing.proficient_for_subject_by_grade_in_year(:reading, 8, 2011)
  end

  def test_proficient_by_race_or_ethnicity
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    expected_result = {
      2011 => { math: 0.816, reading: 0.897, writing: 0.826 },
      2012 => { math: 0.818, reading: 0.893, writing: 0.808 },
      2013 => { math: 0.805, reading: 0.901, writing: 0.810 },
      2014 => { math: 0.800, reading: 0.855, writing: 0.789 }
    }

    assert_equal expected_result, academy_20.statewide_testing.proficient_by_race_or_ethnicity(:asian)
  end

  def test_it_removes_some_bullshit
    make_a_dr
    east_yuma = @dr.find_by_name('EAST YUMA COUNTY RJ-2').statewide_testing
    west_yuma = @dr.find_by_name('WEST YUMA COUNTY RJ-1').statewide_testing
    woodlin   = @dr.find_by_name('WOODLIN R-104').statewide_testing

    expected_1  = {}
    expected_2  = { 2008 => { writing: 0.341 }, 2009 => { writing: 0.402 } }
    expected_3  = { 2008 => { math: 0.512 }, 2009 => { math: 0.458 } }

    assert_equal expected_1, woodlin.proficient_by_grade(3)
    assert_equal expected_2, east_yuma.proficient_by_grade(3)
    assert_equal expected_3, west_yuma.proficient_by_grade(3)
  end
end
