require_relative '../lib/statewide'

class StatewideTestingTest < Minitest::Test
  def test_it_loads_some_shit
    dr = DistrictRepository.new('/3rd grade students scoring proficient or above on the CSAP_TCAP.csv')
    binding.pry
    assert StatewideTesting.new(data)
  end
end
