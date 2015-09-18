require_relative '../lib/district_repository'
require 'pry'

class EnrollmentTest < Minitest::Test
  def test_participation_in_year
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 23973, district.enrollment.participation_in_year(2012)
  end

  def test_participation_by_year
    dr = DistrictRepository.from_csv('/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")
    expected_result = {2009=>22620,2010=>23119,2011=>23657,2012=>23973,2013=>24481,2014=>24578}

    assert_equal expected_result, district.enrollment.participation_by_year
  end

  def test_online_participation_in_year
    dr = DistrictRepository.from_csv('/Online pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 341, district.enrollment.online_participation_in_year(2013)
  end

  def test_online_participation_by_year
    dr = DistrictRepository.from_csv('/Online pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")
    expected_result = {2011=>33,2012=>35,2013=>341}

    assert_equal expected_result, district.enrollment.online_participation_by_year
  end

  def test_remediation_in_higher_education
    dr = DistrictRepository.from_csv('/Remediation in higher education.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.264, district.enrollment.online_participation_in_year(2009)
  end

  def test_kindergartners_in_full_day_programs
    dr = DistrictRepository.from_csv('/Kindergartners in full-day program.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.391, district.enrollment.online_participation_in_year(2007)
  end

  def test_graduation_rate_in_year
    dr = DistrictRepository.from_csv('/High school graduation rates.csv')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.895, district.enrollment.graduation_rate_in_year(2010)
  end

  def test_graduation_rate_by_year
    dr = DistrictRepository.from_csv('/High school graduation rates.csv')
    district = dr.find_by_name("ACADEMY 20")

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

  def test_special_education
    dr = DistrictRepository.from_csv('/Special education.csv')
    # district = dr.find_by_name("ACADEMY 20")

    # assert_equal 0.889, district.enrollment.graduation_rate_in_year(2012)
  end
end
