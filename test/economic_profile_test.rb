require_relative '../lib/district_repository'
require 'pry'

class EconomicProfileTest < Minitest::Test

  def path
    File.expand_path '../data', __dir__
  end

  def make_a_dr
    @dr ||= DistrictRepository.from_csv(path)
  end

  def test_free_or_reduced_lunch_by_year
    make_a_dr
    academy_20 = @dr.find_by_name("ACADEMY 20")

    expected_result = {
                        2000 => 0.040,
                        2001 => 0.047,
                        2002 => 0.048,
                        2003 => 0.060,
                        2004 => 0.059,
                        2005 => 0.058,
                        2006 => 0.072,
                        2007 => 0.080,
                        2008 => 0.093,
                        2009 => 0.103,
                        2010 => 0.113,
                        2011 => 0.119,
                        2012 => 0.125,
                        2013 => 0.131,
                        2014 => 0.127,
                      }

    assert_equal expected_result, academy_20.economic_profile.free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year
    make_a_dr
    academy_20 = @dr.find_by_name("ACADEMY 20")

    assert_equal 0.125, academy_20.economic_profile.free_or_reduced_lunch_in_year(2012)
    assert_equal nil, academy_20.economic_profile.free_or_reduced_lunch_in_year(2234012)
  end

  def test_school_aged_children_in_poverty_by_year
    make_a_dr
    academy_20 = @dr.find_by_name("ACADEMY 20")

    expected_result = {
                        1995 => 0.032,
                        1997 => 0.035,
                        1999 => 0.032,
                        2000 => 0.031,
                        2001 => 0.029,
                        2002 => 0.033,
                        2003 => 0.037,
                        2004 => 0.034,
                        2005 => 0.042,
                        2006 => 0.036,
                        2007 => 0.039,
                        2008 => 0.044,
                        2009 => 0.047,
                        2010 => 0.057,
                        2011 => 0.059,
                        2012 => 0.064,
                        2013 => 0.048,
                      }

    assert_equal expected_result, academy_20.economic_profile.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_in_year
    make_a_dr
    academy_20 = @dr.find_by_name("ACADEMY 20")

    assert_equal 0.064, academy_20.economic_profile.school_aged_children_in_poverty_in_year(2012)
    assert_equal nil, academy_20.economic_profile.school_aged_children_in_poverty_in_year(72698)
  end

  def test_title_1_students_by_year
    make_a_dr
    academy_20 = @dr.find_by_name("ACADEMY 20")

    expected_result = {
                       2009 => 0.014,
                       2011 => 0.011,
                       2012 => 0.01,
                       2013 => 0.012,
                       2014 => 0.027
                     }

    assert_equal expected_result, academy_20.economic_profile.title_1_students_by_year
  end

  def test_title_1_students_in_year
    make_a_dr
    academy_20 = @dr.find_by_name("ACADEMY 20")

    assert_equal 0.012, academy_20.economic_profile.title_1_students_in_year(2013)
    assert_equal nil, academy_20.economic_profile.title_1_students_in_year(20685713)
  end


end
