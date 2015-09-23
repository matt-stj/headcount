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
    assert_raises(UnknownDataError) { @ha.kindergarten_participation_rate_variation("ACADEMY 20", "NEW YORK") }
    #assert something when fetched district is nil
    # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
  end

  def test_kindergarten_participation_against_household_income
    make_a_ha


    assert_equal -0.080, @ha.kindergarten_participation_against_household_income("ACADEMY 20")
    assert_equal 0.406, @ha.kindergarten_participation_against_household_income("ASPEN 1")
    assert_equal -0.112, @ha.kindergarten_participation_against_household_income("DEL NORTE C-7")

    #assert something when fetched district is nil
    # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
  end


  def test_kindergarten_participation_correlates_with_household_income
    make_a_ha

    assert_equal false, @ha.kindergarten_participation_correlates_with_household_income("ACADEMY 20")
    assert_equal false, @ha.kindergarten_participation_correlates_with_household_income("ASPEN 1")
    assert_equal false, @ha.kindergarten_participation_correlates_with_household_income("DEL NORTE C-7")

    # assert something when fetched district is nil
    # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
  end

  def test_kindergarten_participation_against_high_school_graduation
    make_a_ha

    @ha.kindergarten_participation_against_high_school_graduation("PUEBLO CITY 60")
  end

end
