require_relative '../lib/district_repository'
require 'pry'

class EnrollmentTest < Minitest::Test
  def test_participation_in_year
    colorado = DistrictRepository.from_csv('/Pupil enrollment.csv').find_by_name("COLORADO")
    academy_20 = DistrictRepository.from_csv('/Pupil enrollment.csv').find_by_name("ACADEMY 20")

    assert_equal 832368, colorado.enrollment.participation_in_year(2009)
    assert_equal 854265, colorado.enrollment.participation_in_year(2011)
    assert_equal 889006, colorado.enrollment.participation_in_year(2014)

    assert_equal 23973, academy_20.enrollment.participation_in_year(2012)
    assert_equal 24578, academy_20.enrollment.participation_in_year(2014)
    assert_equal 22620, academy_20.enrollment.participation_in_year(2009)
  end

  def test_participation_by_year
    adams_arapahoe = DistrictRepository.from_csv('/Pupil enrollment.csv').find_by_name("ADAMS-ARAPAHOE 28J")
    adams_county = DistrictRepository.from_csv('/Pupil enrollment.csv').find_by_name("ADAMS COUNTY 14")

    expected_result_1 = {2009=>36967,2010=>38605,2011=>39696,2012=>39835,2013=>40877,2014=>41729}
    expected_result_2 = {2009=>7422,2010=>7549,2011=>7321,2012=>7500,2013=>7598,2014=>7584}

    assert_equal expected_result_1, adams_arapahoe.enrollment.participation_by_year
    assert_equal expected_result_2, adams_county.enrollment.participation_by_year
  end

  def test_online_participation_in_year
    boulder = DistrictRepository.from_csv('/Online pupil enrollment.csv').find_by_name("BOULDER VALLEY RE 2")
    branson = DistrictRepository.from_csv('/Online pupil enrollment.csv').find_by_name("BRANSON REORGANIZED 82")

    assert_equal 121, boulder.enrollment.online_participation_in_year(2011)
    assert_equal 136, boulder.enrollment.online_participation_in_year(2012)

    assert_equal 409, branson.enrollment.online_participation_in_year(2011)
    assert_equal 436, branson.enrollment.online_participation_in_year(2013)
  end

  def test_online_participation_by_year
    byers = DistrictRepository.from_csv('/Online pupil enrollment.csv').find_by_name("BYERS 32J")
    canon_city = DistrictRepository.from_csv('/Online pupil enrollment.csv').find_by_name("CANON CITY RE-1")
    expected_result_1 = {2011=>0,2012=>83,2013=>135}
    expected_result_2 = {2011=>66,2012=>48,2013=>45}

    assert_equal expected_result_1, byers.enrollment.online_participation_by_year
    assert_equal expected_result_2, canon_city.enrollment.online_participation_by_year
  end

  def test_graduation_rate_in_year
    colorado = DistrictRepository.from_csv('/High school graduation rates.csv').find_by_name("COLORADO")
    academy_20 = DistrictRepository.from_csv('/High school graduation rates.csv').find_by_name("ACADEMY 20")

    assert_equal 0.753, colorado.enrollment.graduation_rate_in_year(2012)
    assert_equal 0.773, colorado.enrollment.graduation_rate_in_year(2014)

    assert_equal 0.895, academy_20.enrollment.graduation_rate_in_year(2010)
    assert_equal 0.913, academy_20.enrollment.graduation_rate_in_year(2013)
  end

  def test_edge_case_truncate_floats
    dr = DistrictRepository.from_csv('/High school graduation rates.csv')
    district = dr.find_by_name("ACADEMY 20")
    expected_result = {2010=>0.895,2011=>0.895,2012=>0.889,2013=>0.913,2014=>0.898}

    assert_equal expected_result, district.enrollment.graduation_rate_by_year
  end

  def test_special_education_in_year
    dr = DistrictRepository.from_csv('/Special education.csv')
    district = dr.find_by_name("MEEKER RE1")

    assert_equal 0.105, district.enrollment.special_education_in_year(2013)
  end

  def test_special_education_by_year
    dr = DistrictRepository.from_csv('/Special education.csv')
    district = dr.find_by_name("MEEKER RE1")
    expected_result = {2009=>0.089, 2011=>0.09, 2012=>0.103, 2013=>0.105, 2010=>0.091, 2014=>0.103}

    assert_equal expected_result, district.enrollment.special_education_by_year
  end

  def test_remediation_in_year
    dr = DistrictRepository.from_csv('/Remediation in higher education.csv')
    district = dr.find_by_name("ADAMS-ARAPAHOE 28J")

    assert_equal 0.614, district.enrollment.remediation_in_year(2010)
  end

  def test_remediation_by_year
    dr = DistrictRepository.from_csv('/Remediation in higher education.csv')
    district = dr.find_by_name("ADAMS-ARAPAHOE 28J")
    expected_result = {2011=>0.533, 2010=>0.614, 2009=>0.601}

    assert_equal expected_result, district.enrollment.remediation_by_year
  end

  def test_kindergartners_participation_in_year
    dr = DistrictRepository.from_csv('/Kindergartners in full-day program.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.391, district.enrollment.kindergarten_participation_in_year(2007)
  end

  def test_kindergartners_participation_by_year
    dr = DistrictRepository.from_csv('/Kindergartners in full-day program.csv')
    district = dr.find_by_name("ADAMS-ARAPAHOE 28J")
    expected_result = {2007=>0.473,
       2006=>0.37,
       2005=>0.201,
       2004=>0.174,
       2008=>0.479,
       2009=>0.73,
       2010=>0.922,
       2011=>0.95,
       2012=>0.973,
       2013=>0.976,
       2014=>0.971}

    assert_equal expected_result, district.enrollment.kindergarten_participation_by_year
  end

  def test_dropout_rate_in_year
    dr = DistrictRepository.from_csv('/Dropout rates by race and ethnicity.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.dropout_rate_in_year(2011)
    assert_equal nil, district.enrollment.dropout_rate_in_year(1850)
  end

  def test_dropout_rate_by_gender_in_year
    dr = DistrictRepository.from_csv('/Dropout rates by race and ethnicity.csv')
    district = dr.find_by_name("ACADEMY 20")
    expected_result = {:female=>0.002, :male=>0.002}

    assert_equal expected_result, district.enrollment.dropout_rate_by_gender_in_year(2011)
    assert_equal nil, district.enrollment.dropout_rate_by_gender_in_year(1776)

  end

  def test_dropout_rate_by_race_in_year
    dr = DistrictRepository.from_csv('/Dropout rates by race and ethnicity.csv')
    district = dr.find_by_name("ACADEMY 20")
    expected_result = { :native_american=>0.0,
                        :asian=>0.0,
                        :black=>0.0,
                        :hispanic=>0.004,
                        :white=>0.002,
                        :pacific_islander=>0.0,
                        :two_or_more=>0.0
                      }

    assert_equal expected_result, district.enrollment.dropout_rate_by_race_in_year(2011)
    assert_equal nil, district.enrollment.dropout_rate_by_race_in_year(1442)

  end

  def test_dropout_rate_for_race_or_ethnicity
    dr = DistrictRepository.from_csv('/Dropout rates by race and ethnicity.csv')
    district = dr.find_by_name("ACADEMY 20")
    expected_result = {2011=>0.0, 2012=>0.007}

    assert_equal expected_result, district.enrollment.dropout_rate_for_race_or_ethnicity(:asian)
    assert_raises(UnknownDataError) { district.enrollment.dropout_rate_for_race_or_ethnicity(:alien) }
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_z
    dr = DistrictRepository.from_csv('/Dropout rates by race and ethnicity.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.007, district.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
    assert_raises(UnknownDataError) { district.enrollment.dropout_rate_for_race_or_ethnicity(:alien) }
    assert_equal nil, district.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 1950)

  end

end

# def test_participation_by_race_or_ethnicity
#   skip
#   dr = DistrictRepository.from_csv('/Pupil enrollment by race_ethnicity.csv')
#   district = dr.find_by_name("Colorado")
#   district.participation_by_race_or_ethnicity('asian students')
#   assert_equal {2007 => 0.034,
#                 2008 => 0.036,
#                 2009 => 0.037,
#                 2010 => 0.030,
#                 2011 => 0.031,
#                 2012 => 0.032,
#                 2013 => 0.030,
#                 2014 => 0.030}, district.enrollment.participation_by_race_or_ethnicity(:asian)
# end
