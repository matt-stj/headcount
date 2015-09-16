require 'csv'
require 'pry'


class ThirdGradeLoader
  def load_all
    file = '/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv'
    CSV.open(file, headers: true, header_converters: :symbol)
  end
end

class ThirdGrade
  attr_reader :location, :score, :timeframe, :dataformat, :data
  def initialize(row, third_grade_repo)
    @location = row[:location]
    @score = row[:score]
    @timeframe = row[:timeframe]
    @dataformat = row[:dataformat]
    @data = row[:data]
  end
end

class ThirdGradeRepository
  attr_reader :all, :head_count
  def initialize(rows, head_count)
    @all ||= load_third_graders(rows)
    @head_count ||= head_count
  end

  def load_third_graders(rows)
    @all = Hash.new(0)
    rows.map { |row| @all[row] = ThirdGrade.new(row, self)}
    @all
  end

  def all_things
    @all.values
  end

  def find_by_name(name)
  end

  def find_all_matching
  end

  def method_name

  end
end

class HeadCount
  attr_reader :third_grade, :third_grade_repository
  def initialize
    @third_grade ||= ThirdGradeLoader.new.load_all
  end

  def start
    @third_grade_repository ||= ThirdGradeRepository.new(@third_grade, self)
  end
end

a = HeadCount.new
b = a.start
b




# Unique Districts
# hash.map {|row| row[:location].upcase}.uniq
# # => ["COLORADO", "ACADEMY 20", "ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J", "AGATE 300", "AGUILAR REORGANIZED 6", "AKRON R-1", "ALAMOSA RE-11J", "ARCHULETA COUNTY 50 JT", "ARICKAREE R-2", "ARRIBA-FLAGLER C-20", "ASPEN 1", "AULT-HIGHLAND RE-9", "BAYFIELD 10 JT-R", "BENNETT 29J", "BETHUNE R-5", "BIG SANDY 100J", "BOULDER VALLEY RE 2", "BRANSON REORGANIZED 82", "BRIGGSDALE RE-10", "BRIGHTON 27J", "BRUSH RE-2(J)", "BUENA VISTA R-31", "BUFFALO RE-4", "BURLINGTON RE-6J", "BYERS 32J", "CALHAN RJ-1", "CAMPO RE-6", "CANON CITY RE-1", "CENTENNIAL R-1", "CENTER 26 JT", "CHERAW 31", "CHERRY CREEK 5", "CHEYENNE COUNTY RE-5", "CHEYENNE MOUNTAIN 12", "CLEAR CREEK RE-1", "COLORADO SPRINGS 11", "COTOPAXI RE-3", "CREEDE CONSOLIDATED 1", "CRIPPLE CREEK-VICTOR RE-1", "CROWLEY COUNTY RE-1-J", "CUSTER COUNTY SCHOOL DISTRICT C-1", "DE BEQUE 49JT", "DEER TRAIL 26J", "DEL NORTE C-7", "DELTA COUNTY 50(J)", "DENVER COUNTY 1", "DOLORES COUNTY RE NO.2", "DOLORES RE-4A", "DOUGLAS COUNTY RE 1", "DURANGO 9-R", "EADS ...


# @districts = @pupil_data.group_by {|x| x[:location] }                                         # => {"Colorado"=>[{:location=>"Colorado", :timeframe=>"2009", :dataformat=>"Number", :data=>"832368"}, {:location=>"Colorado", :timeframe=>"2010", :dataformat=>"Number", :data=>"843316"}, {:location=>"Colorado", :timeframe=>"2011", :dataformat=>"Number", :data=>"854265"}, {:location=>"Colorado", :timeframe=>"2012", :dataformat=>"Number", :data=>"863561"}, {:location=>"Colorado", :timeframe=>"2013", :dataformat=>"Number", :data=>"876999"}, {:location=>"Colorado", :timeframe=>"2014", :dataformat=>"Number", :data=>"889006"}], "ACADEMY 20"=>[{:location=>"ACADEMY 20", :timeframe=>"2009", :dataformat=>"Number", :data=>"22620"}, {:location=>"ACADEMY 20", :timeframe=>"2010", :dataformat=>"Number", :data=>"23119"}, {:location=>"ACADEMY 20", :timeframe=>"2011", :dataformat=>"Number", :data=>"23657"}, {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Number", :data=>"23973"}, {:location...
# @districts.each do |key, value|                                                               # => {"Colorado"=>[{:location=>"Colorado", :timeframe=>"2009", :dataformat=>"Number", :data=>"832368"}, {:location=>"Colorado", :timeframe=>"2010", :dataformat=>"Number", :data=>"843316"}, {:location=>"Colorado", :timeframe=>"2011", :dataformat=>"Number", :data=>"854265"}, {:location=>"Colorado", :timeframe=>"2012", :dataformat=>"Number", :data=>"863561"}, {:location=>"Colorado", :timeframe=>"2013", :dataformat=>"Number", :data=>"876999"}, {:location=>"Colorado", :timeframe=>"2014", :dataformat=>"Number", :data=>"889006"}], "ACADEMY 20"=>[{:location=>"ACADEMY 20", :timeframe=>"2009", :dataformat=>"Number", :data=>"22620"}, {:location=>"ACADEMY 20", :timeframe=>"2010", :dataformat=>"Number", :data=>"23119"}, {:location=>"ACADEMY 20", :timeframe=>"2011", :dataformat=>"Number", :data=>"23657"}, {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Number", :data=>"23973"}, {:location...
#   value.select {|hash| hash[:location] == "ACADEMY 20" && hash[:timeframe] == "2009"}         # => [], [{:location=>"ACADEMY 20", :timeframe=>"2009", :dataformat=>"Number", :data=>"22620"}], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []
# end


# Nested Hashes
#      @districts = data.group_by {|x| x[:location] }
#     new_hash = {}
#     @districts.each do |key, value|
#       new_hash[key] = Hash.new(:enrollment)
#       new_hash[key][:enrollment] = Hash.new(:pupil)
#       new_hash[key][:enrollment][:pupil] = {}
#     end
#
#     # @districts["Colorado"].each do |hash|  # => [{:location=>"Colorado", :timeframe=>"2009", :dataformat=>"Number", :data=>"832368"}, {:location=>"Colorado", :timeframe=>"2010", :dataformat=>"Number", :data=>"843316"}, {:location=>"Colorado", :timeframe=>"2011", :dataformat=>"Number", :data=>"854265"}, {:location=>"Colorado", :timeframe=>"2012", :dataformat=>"Number", :data=>"863561"}, {:location=>"Colorado", :timeframe=>"2013", :dataformat=>"Number", :data=>"876999"}, {:location=>"Colorado", :timeframe=>"2014", :dataformat=>"Number", :data=>"889006"}]
#     #   {hash[:timeframe] => hash[:data]}    # => {"2009"=>"832368"}, {"2010"=>"843316"}, {"2011"=>"854265"}, {"2012"=>"863561"}, {"2013"=>"876999"}, {"2014"=>"889006"}
#     # end                                    # => [{:location=>"Colorado", :timeframe=>"2009", :dataformat=>"Number", :data=>"832368"}, {:location=>"Colorado", :timeframe=>"2010", :dataformat=>"Number", :data=>"843316"}, {:location=>"Colorado", :timeframe=>"2011", :dataformat=>"Number", :data=>"854265"}, {:location=>"Colorado", :timeframe=>"2012", :dataformat=>"Number", :data=>"863561"}, {:location=>"Colorado", :timeframe=>"2013", :dataformat=>"Number", :data=>"876999"}, {:location=>"Colorado", :timeframe=>"2014", :dataformat=>"Number", :data=>"889006"}]
#
#     new_hash
