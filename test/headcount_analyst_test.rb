require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'
require 'pry'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :path

  def path
    File.expand_path '../data', __dir__
  end

  def make_a_ha
    dr ||= DistrictRepository.from_csv(path)
    @ha = HeadcountAnalyst.new(dr)
  end

  def test_kindergarten_participation_rate_variation
    make_a_ha

    assert_equal -0.123, @ha.kindergarten_participation_rate_variation("ACADEMY 20")
  end

  def test_top_statewide_testing_year_over_year_growth_third_grade
    make_a_ha

    assert_equal -0.018, @ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:math)
  end

  def test_top_statewide_testing_year_over_year_growth_eigth_grade
    make_a_ha

    assert_equal 0.039, @ha.top_statewide_testing_year_over_year_growth_in_8th_grade(:reading)
  end


end
