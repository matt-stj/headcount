require_relative '../lib/district_repository'

class StatewideTestingTest < Minitest::Test
  def test_it_loads_some_shit
    skip
    dr = DistrictRepository.new('/3rd grade students scoring proficient or above on the CSAP_TCAP.csv')
    district = dr.find_by_name("CANON CITY RE-1")
    binding.pry
    assert third_grade_proficiency
  end
end
