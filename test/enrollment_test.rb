require_relative '../lib/district_repository'

class EnrollmentTest < Minitest::Test
  def path
    File.expand_path '../data', __dir__
  end

  def make_a_dr
    @dr ||= DistrictRepository.from_csv(path)
  end

  def test_edge_case_truncate_floats
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    expected_result = { 2010 => 0.895,
                        2011 => 0.895,
                        2012 => 0.889,
                        2013 => 0.913,
                        2014 => 0.898
                     }

    assert_equal expected_result, academy_20.enrollment.graduation_rate_by_year
  end

  def test_participation_in_year
    make_a_dr
    colorado = @dr.find_by_name('COLORADO')
    academy_20 = @dr.find_by_name('ACADEMY 20')

    assert_equal 832_368, colorado.enrollment.participation_in_year(2009)
    assert_equal 854_265, colorado.enrollment.participation_in_year(2011)
    assert_equal 889_006, colorado.enrollment.participation_in_year(2014)

    assert_equal 23_973, academy_20.enrollment.participation_in_year(2012)
    assert_equal 24_578, academy_20.enrollment.participation_in_year(2014)
    assert_equal 22_620, academy_20.enrollment.participation_in_year(2009)
  end

  def test_participation_in_year_returns_nil_if_the_year_isnt_found
    make_a_dr
    colorado = @dr.find_by_name('COLORADO')
    academy_20 = @dr.find_by_name('ACADEMY 20')

    assert_equal nil, colorado.enrollment.participation_in_year(4000)
    assert_equal nil, academy_20.enrollment.participation_in_year(2489)
  end

  def test_participation_by_year
    make_a_dr
    adams_arapahoe = @dr.find_by_name('ADAMS-ARAPAHOE 28J')
    adams_county = @dr.find_by_name('ADAMS COUNTY 14')

    expected_result_1 = { 2009 => 36_967,
                          2010 => 38_605,
                          2011 => 39_696,
                          2012 => 39_835,
                          2013 => 40_877,
                          2014 => 41_729
                       }
    expected_result_2 = { 2009 => 7422,
                          2010 => 7549,
                          2011 => 7321,
                          2012 => 7500,
                          2013 => 7598,
                          2014 => 7584
                       }

    assert_equal expected_result_1, adams_arapahoe.enrollment.participation_by_year
    assert_equal expected_result_2, adams_county.enrollment.participation_by_year
  end

  def test_online_participation_in_year
    make_a_dr
    boulder = @dr.find_by_name('BOULDER VALLEY RE 2')
    branson = @dr.find_by_name('BRANSON REORGANIZED 82')

    assert_equal 121, boulder.enrollment.online_participation_in_year(2011)
    assert_equal 136, boulder.enrollment.online_participation_in_year(2012)

    assert_equal 409, branson.enrollment.online_participation_in_year(2011)
    assert_equal 436, branson.enrollment.online_participation_in_year(2013)
  end

  def test_online_participation_in_year_returns_nil_if_the_year_isnt_found
    make_a_dr
    boulder = @dr.find_by_name('BOULDER VALLEY RE 2')
    branson = @dr.find_by_name('BRANSON REORGANIZED 82')

    assert_equal nil, boulder.enrollment.online_participation_in_year(2042)
    assert_equal nil, branson.enrollment.online_participation_in_year(4328)
  end

  def test_online_participation_by_year
    make_a_dr
    byers = @dr.find_by_name('BYERS 32J')
    canon_city = @dr.find_by_name('CANON CITY RE-1')
    expected_result_1 = { 2011 => 0,
                          2012 => 83,
                          2013 => 135
                       }
    expected_result_2 = { 2011 => 66,
                          2012 => 48,
                          2013 => 45
                       }

    assert_equal expected_result_1, byers.enrollment.online_participation_by_year
    assert_equal expected_result_2, canon_city.enrollment.online_participation_by_year
  end

  def test_graduation_rate_in_year
    make_a_dr
    colorado = @dr.find_by_name('COLORADO')
    academy_20 = @dr.find_by_name('ACADEMY 20')

    assert_equal 0.753, colorado.enrollment.graduation_rate_in_year(2012)
    assert_equal 0.773, colorado.enrollment.graduation_rate_in_year(2014)

    assert_equal 0.895, academy_20.enrollment.graduation_rate_in_year(2010)
    assert_equal 0.913, academy_20.enrollment.graduation_rate_in_year(2013)
  end

  def test_graduation_rate_in_year_returns_nil_if_the_year_isnt_found
    make_a_dr
    colorado = @dr.find_by_name('COLORADO')
    academy_20 = @dr.find_by_name('ACADEMY 20')

    assert_equal nil, colorado.enrollment.graduation_rate_in_year(1245)
    assert_equal nil, academy_20.enrollment.graduation_rate_in_year(9867)
  end

  def test_special_education_in_year
    make_a_dr
    meeker = @dr.find_by_name('MEEKER RE1')
    cotopaxi = @dr.find_by_name('COTOPAXI RE-3')

    assert_equal 0.105, meeker.enrollment.special_education_in_year(2013)
    assert_equal 0.103, meeker.enrollment.special_education_in_year(2012)

    assert_equal 0.089, cotopaxi.enrollment.special_education_in_year(2009)
    assert_equal 0.155, cotopaxi.enrollment.special_education_in_year(2012)
  end

  def test_special_education_by_year
    make_a_dr
    meeker = @dr.find_by_name('MEEKER RE1')
    delta = @dr.find_by_name('DELTA COUNTY 50(J)')
    expected_result_1 = { 2009 => 0.089,
                          2011 => 0.09,
                          2012 => 0.103,
                          2013 => 0.105,
                          2010 => 0.091,
                          2014 => 0.103
                     }
    expected_result_2 = { 2009 => 0.1,
                          2010 => 0.104,
                          2011 => 0.103,
                          2012 => 0.106,
                          2013 => 0.116,
                          2014 => 0.118
                       }

    assert_equal expected_result_1, meeker.enrollment.special_education_by_year
    assert_equal expected_result_2, delta.enrollment.special_education_by_year
  end

  def test_remediation_in_year
    make_a_dr
    adams_arapahoe = @dr.find_by_name('ADAMS-ARAPAHOE 28J')
    johnstown = @dr.find_by_name('JOHNSTOWN-MILLIKEN RE-5J')

    assert_equal 0.614, adams_arapahoe.enrollment.remediation_in_year(2010)
    assert_equal 0.533, adams_arapahoe.enrollment.remediation_in_year(2011)
    assert_equal 0.601, adams_arapahoe.enrollment.remediation_in_year(2009)

    assert_equal 0.516, johnstown.enrollment.remediation_in_year(2011)
    assert_equal 0.456, johnstown.enrollment.remediation_in_year(2010)
    assert_equal 0.5, johnstown.enrollment.remediation_in_year(2009)
  end

  def test_remediation_in_year_returns_nil_if_the_year_isnt_found
    make_a_dr
    adams_arapahoe = @dr.find_by_name('ADAMS-ARAPAHOE 28J')
    gilpin = @dr.find_by_name('GILPIN COUNTY RE-1')
    greeley = @dr.find_by_name('GREELEY 6')

    assert_equal nil, adams_arapahoe.enrollment.remediation_in_year(3010)
    assert_equal nil, gilpin.enrollment.remediation_in_year(1)
    assert_equal nil, greeley.enrollment.remediation_in_year(9_000_000)
  end

  def test_remediation_by_year
    make_a_dr
    adams_arapahoe = @dr.find_by_name('ADAMS-ARAPAHOE 28J')
    harrison = @dr.find_by_name('HARRISON 2')
    expected_result_1 = { 2011 => 0.533,
                          2010 => 0.614,
                          2009 => 0.601
                     }
    expected_result_2 = { 2011 => 0.614,
                          2010 => 0.634,
                          2009 => 0.573
                       }

    assert_equal expected_result_1, adams_arapahoe.enrollment.remediation_by_year
    assert_equal expected_result_2, harrison.enrollment.remediation_by_year
  end

  def test_kindergartners_participation_in_year
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    falcon = @dr.find_by_name('FALCON 49')
    keenesburg = @dr.find_by_name('KEENESBURG RE-3(J)')

    assert_equal 0.391, academy_20.enrollment.kindergarten_participation_in_year(2007)
    assert_equal 0.484, falcon.enrollment.kindergarten_participation_in_year(2008)
    assert_equal 0.432, keenesburg.enrollment.kindergarten_participation_in_year(2008)
  end

  def test_kindergartners_participation_in_year_returns_nil_if_year_isnt_found
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    fountain = @dr.find_by_name('FOUNTAIN 8')
    haxtun = @dr.find_by_name('HAXTUN RE-2J')

    assert_equal nil, academy_20.enrollment.kindergarten_participation_in_year(1776)
    assert_equal nil, fountain.enrollment.kindergarten_participation_in_year(65)
    assert_equal nil, haxtun.enrollment.kindergarten_participation_in_year(1234)
  end

  def test_kindergartners_participation_by_year
    make_a_dr
    adams_arapahoe = @dr.find_by_name('ADAMS-ARAPAHOE 28J')
    denver = @dr.find_by_name('DENVER COUNTY 1')
    expected_result_1 = { 2007 => 0.473,
                          2006 => 0.37,
                          2005 => 0.201,
                          2004 => 0.174,
                          2008 => 0.479,
                          2009 => 0.73,
                          2010 => 0.922,
                          2011 => 0.95,
                          2012 => 0.973,
                          2013 => 0.976,
                          2014 => 0.971
                     }
    expected_result_2 = { 2007 => 0.721,
                          2006 => 0.667,
                          2005 => 0.631,
                          2004 => 0.517,
                          2008 => 0.875,
                          2009 => 0.93,
                          2010 => 0.944,
                          2011 => 0.948,
                          2012 => 0.969,
                          2013 => 0.993,
                          2014 => 0.995
                       }

    assert_equal expected_result_1, adams_arapahoe.enrollment.kindergarten_participation_by_year
    assert_equal expected_result_2, denver.enrollment.kindergarten_participation_by_year
  end

  def test_dropout_rate_in_year
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    florence = @dr.find_by_name('FLORENCE RE-2')
    campo = @dr.find_by_name('CAMPO RE-6')

    assert_equal 0.002, academy_20.enrollment.dropout_rate_in_year(2011)
    assert_equal 0.025, florence.enrollment.dropout_rate_in_year(2011)
    assert_equal 0.036, campo.enrollment.dropout_rate_in_year(2012)
  end

  def test_dropout_rate_in_year_returns_nil_if_the_year_isnt_found
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    creede = @dr.find_by_name('CREEDE CONSOLIDATED 1')
    eads = @dr.find_by_name('EADS RE-1')

    assert_equal nil, academy_20.enrollment.dropout_rate_in_year(1850)
    assert_equal nil, creede.enrollment.dropout_rate_in_year(6532)
    assert_equal nil, eads.enrollment.dropout_rate_in_year(9_809_986)
  end

  def test_dropout_rate_by_gender_in_year
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    brighton = @dr.find_by_name('BRIGHTON 27J')
    brush = @dr.find_by_name('BRUSH RE-2(J)')

    expected_result_1 = { female: 0.002,
                          male: 0.002
                     }
    expected_result_2 = { female: 0.019,
                          male: 0.034
                       }
    expected_result_3 = { female: 0.008,
                          male: 0.023
                       }

    assert_equal expected_result_1, academy_20.enrollment.dropout_rate_by_gender_in_year(2011)
    assert_equal expected_result_2, brighton.enrollment.dropout_rate_by_gender_in_year(2012)
    assert_equal expected_result_3, brush.enrollment.dropout_rate_by_gender_in_year(2012)
  end

  def test_dropout_rate_by_gender_in_year_returns_nil_if_year_isnt_found
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    buena_vista = @dr.find_by_name('BUENA VISTA R-31')
    buffalo = @dr.find_by_name('BUFFALO RE-4')

    assert_equal nil, academy_20.enrollment.dropout_rate_by_gender_in_year(1776)
    assert_equal nil, buena_vista.enrollment.dropout_rate_by_gender_in_year(1111)
    assert_equal nil, buena_vista.enrollment.dropout_rate_by_gender_in_year(6785)
  end

  def test_dropout_rate_by_race_in_year
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    archuletta = @dr.find_by_name('ARCHULETA COUNTY 50 JT')

    expected_result_1 = { native_american: 0.0,
                          asian: 0.0,
                          black: 0.0,
                          hispanic: 0.004,
                          white: 0.002,
                          pacific_islander: 0.0,
                          two_or_more: 0.0
                      }
    expected_result_2 = { asian: 0,
                          black: 0,
                          hispanic: 0.038,
                          native_american: 0.067,
                          pacific_islander: 0,
                          two_or_more: 0,
                          white: 0.015
                       }

    assert_equal expected_result_1, academy_20.enrollment.dropout_rate_by_race_in_year(2011)
    assert_equal expected_result_2, archuletta.enrollment.dropout_rate_by_race_in_year(2012)
  end

  def test_dropout_rate_by_race_in_year_returns_nil_if_the_year_isnt_found
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    gunnison = @dr.find_by_name('GUNNISON WATERSHED RE1J')
    east_grand = @dr.find_by_name('EAST GRAND 2')

    assert_equal nil, academy_20.enrollment.dropout_rate_by_race_in_year(1442)
    assert_equal nil, gunnison.enrollment.dropout_rate_by_race_in_year(01010011)
    assert_equal nil, east_grand.enrollment.dropout_rate_by_race_in_year(98_765)
  end

  def test_dropout_rate_for_race_or_ethnicity
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    park_county = @dr.find_by_name('PARK COUNTY RE-2')
    otis = @dr.find_by_name('OTIS R-3')

    expected_result_1 = { 2011 => 0.0,
                          2012 => 0.007
                     }
    expected_result_2 = { 2011 => 0.029,
                          2012 => 0.037
                        }
    expected_result_3 = { 2011 => 0.022,
                          2012 => 0
                       }

    assert_equal expected_result_1, academy_20.enrollment.dropout_rate_for_race_or_ethnicity(:asian)
    assert_equal expected_result_2, park_county.enrollment.dropout_rate_for_race_or_ethnicity(:hispanic)
    assert_equal expected_result_3, otis.enrollment.dropout_rate_for_race_or_ethnicity(:white)
  end

  def test_dropout_rate_for_race_or_ethnicity_returns_Unknown_Data_Error_if_the_race_isnt_found
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    moffat = @dr.find_by_name('MOFFAT 2')
    northglenn = @dr.find_by_name('NORTHGLENN-THORNTON 12')

    assert_raises(UnknownRaceError) { academy_20.enrollment.dropout_rate_for_race_or_ethnicity(:alien) }
    assert_raises(UnknownRaceError) { moffat.enrollment.dropout_rate_for_race_or_ethnicity(:crustacean) }
    assert_raises(UnknownRaceError) { northglenn.enrollment.dropout_rate_for_race_or_ethnicity(:marsupial) }
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    estes = @dr.find_by_name('PARK (ESTES PARK) R-3')
    wiggins = @dr.find_by_name('WIGGINS RE-50(J)')

    assert_equal 0.007, academy_20.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
    assert_equal 0.045, estes.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:hispanic, 2011)
    assert_equal 0.005, wiggins.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:white, 2012)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_nil_if_the_year_isnt_found
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    lone_star = @dr.find_by_name('LONE STAR 101')
    hinsdale = @dr.find_by_name('HINSDALE COUNTY RE 1')

    assert_equal nil, academy_20.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 1950)
    assert_equal nil, lone_star.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:white, 1)
    assert_equal nil, hinsdale.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:black, 999_999)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_Unknown_Data_Error_if_the_race_isnt_found
    make_a_dr
    academy_20 = @dr.find_by_name('ACADEMY 20')
    kiowa = @dr.find_by_name('KIOWA C-2')
    lewis_palmer = @dr.find_by_name('LEWIS-PALMER 38')

    assert_raises(UnknownRaceError) { academy_20.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:reptile, 2012) }
    assert_raises(UnknownRaceError) { kiowa.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:amphibian, 2011) }
    assert_raises(UnknownRaceError) { lewis_palmer.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:bird, 2012) }
  end

  def test_participation_by_race_or_ethnicity
    make_a_dr
    alamosa = @dr.find_by_name('ALAMOSA RE-11J')
    colorado = @dr.find_by_name('COLORADO')

    expected_result_1 = { 2007 => 0.59,
                          2008 => 0.594,
                          2009 => 0.607,
                          2010 => 0.64,
                          2011 => 0.636,
                          2012 => 0.649,
                          2013 => 0.662,
                          2014 => 0.671
                       }
    expected_result_2 = { 2007 => 0.034,
                          2008 => 0.036,
                          2009 => 0.037,
                          2010 => 0.030,
                          2011 => 0.031,
                          2012 => 0.032,
                          2013 => 0.030,
                          2014 => 0.030
                        }

    assert_equal expected_result_1, alamosa.enrollment.participation_by_race_or_ethnicity(:hispanic)
    assert_equal expected_result_2, colorado.enrollment.participation_by_race_or_ethnicity(:asian)
    assert_raises(UnknownRaceError) { alamosa.enrollment.participation_by_race_or_ethnicity(:reptile) }
  end

  def test_participation_by_race_or_ethnicity_in_year
    make_a_dr
    aspen = @dr.find_by_name('ASPEN 1')
    expected_result = { native_american: 0.0,
                        asian: 0.02,
                        black: 0.01,
                        hispanic: 0.12,
                        white: 0.85,
                        pacific_islander: 0.0,
                        two_or_more: 0.0 }
    expected_result = { native_american: 0.0, asian: 0.02, black: 0.01, hispanic: 0.12, white: 0.85, pacific_islander: 0.0, two_or_more: 0.0 }

    assert_equal expected_result, aspen.enrollment.participation_by_race_or_ethnicity_in_year(2007)
  end
end
