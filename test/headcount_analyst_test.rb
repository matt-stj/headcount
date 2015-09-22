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

  def test_kindergarten_participation_rate_variation_against_state
    make_a_ha

    assert_equal -0.123, @ha.kindergarten_participation_rate_variation("ACADEMY 20", 'state')
    assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "ACADEMY 20")
    assert_equal -0.593, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "ASPEN 1")
    #assert something when fetched district is nil
    # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
  end

  def test_kindergarten_participation_against_household_income
    make_a_ha


    assert_equal -0.080, @ha.kindergarten_participation_against_household_income("ACADEMY 20")

    #assert something when fetched district is nil
    # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
  end



end
