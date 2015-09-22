require_relative '../lib/district_repository'
require 'pry'

class StatewideTestingTest < Minitest::Test

  def path
    File.expand_path '../data', __dir__
  end

  def make_a_dr
    @dr ||= DistrictRepository.from_csv(path)
  end

  def test_it_loads_some_shit
    skip
    dr = DistrictRepository.new('/3rd grade students scoring proficient or above on the CSAP_TCAP.csv')
    district = dr.find_by_name("CANON CITY RE-1")
    binding.pry
    assert third_grade_proficiency
  end

  def test_proficient_for_subject_by_race_in_year
    make_a_dr
    colorado = @dr.find_by_name("COLORADO")

    assert_equal 0.656, colorado.statewide_testing.proficient_for_subject_by_race_in_year(:writing, :asian, 2011)
  end

end
