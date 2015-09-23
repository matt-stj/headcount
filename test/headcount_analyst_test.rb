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

  def test_top_statewide_testing_year_over_year_growth_in_3rd_grade
    make_a_ha

    assert_equal ["WILEY RE-13 JT", 0.3], @ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:math)
  end

#   def test_kindergarten_participation_rate_variation_against_state
#     make_a_ha
#
#     assert_equal 0.766, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'state')
#     assert_equal 1.0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", :against => "ACADEMY 20")
#     assert_equal 0.406, @ha.kindergarten_participation_rate_variation("ACADEMY 20", :against =>  "ASPEN 1")
#     # assert something when fetched district is nil
#     # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
#   end
#
#   def test_kindergarten_participation_against_household_income
#     make_a_ha
#
#
#     assert_equal 0.501, @ha.kindergarten_participation_against_household_income("ACADEMY 20")
#     assert_equal 1.631, @ha.kindergarten_participation_against_household_income("ASPEN 1")
#     assert_equal 1.282, @ha.kindergarten_participation_against_household_income("DEL NORTE C-7")
#
#     #assert something when fetched district is nil
#     # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
#   end
#
#
#   def test_kindergarten_participation_correlates_with_household_income
#     make_a_ha
#
#     assert_equal true, @ha.kindergarten_participation_correlates_with_household_income(:for => "DEL NORTE C-7")
#     assert_equal false, @ha.kindergarten_participation_correlates_with_household_income(:for => "AGUILAR REORGANIZED 6")
#     assert_equal false, @ha.kindergarten_participation_correlates_with_household_income(:for => "state")
#
#     # assert something when fetched district is nil
#     # assert_equal 0, @ha.kindergarten_participation_rate_variation("ACADEMY 20", "hi there")
#
#     # need :across=>
#   end
#
#   def test_kindergarten_participation_against_high_school_graduation_for_one_district
#     make_a_ha
#
#     assert_equal 0.641, @ha.kindergarten_participation_against_high_school_graduation("ACADEMY 20")
#     assert_equal 0.255, @ha.kindergarten_participation_rate_variation("CHERRY CREEK 5", :against => 'state')
#     assert_equal 1.144, @ha.grad_diff_from_state("CHERRY CREEK 5")
#     assert_equal 0.222, @ha.kindergarten_participation_against_high_school_graduation("CHERRY CREEK 5")
#   end
#
#   def test_kindergarten_participation_correlates_with_high_school_graduation
#     make_a_ha
#
#     assert_equal false, @ha.kindergarten_participation_correlates_with_high_school_graduation("CHERRY CREEK 5")
#     assert_equal true, @ha.kindergarten_participation_correlates_with_high_school_graduation("ARICKAREE R-2")
#     assert_equal false, @ha.kindergarten_participation_correlates_with_high_school_graduation("state")
#   end
#
end
