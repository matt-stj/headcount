require 'csv'


class ThirdGradeLoader
  def load_all
    file = 'Users/rossedfort/code/mod_1/projects/headcount/data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv'
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
# => #<ThirdGradeRepository:0x007f9c6994ebb8 @all={#<CSV::Row location:"Colorado" score:"Math" timeframe:"2008" dataformat:"Percent" data:"0.697">=>#<ThirdGrade:0x007f9c69946e90 @location="Colorado", @score="Math", @timeframe="2008", @dataformat="Percent", @data="0.697">, #<CSV::Row location:"Colorado" score:"Math" timeframe:"2009" dataformat:"Percent" data:"0.691">=>#<ThirdGrade:0x007f9c69946260 @location="Colorado", @score="Math", @timeframe="2009", @dataformat="Percent", @data="0.691">, #<CSV::Row location:"Colorado" score:"Math" timeframe:"2010" dataformat:"Percent" data:"0.706">=>#<ThirdGrade:0x007f9c69945950 @location="Colorado", @score="Math", @timeframe="2010", @dataformat="Percent", @data="0.706">, #<CSV::Row location:"Colorado" score:"Reading" timeframe:"2008" dataformat:"Percent" data:"0.703">=>#<ThirdGrade:0x007f9c69945040 @location="Colorado", @score="Reading", @timeframe="2008", @dataformat="Percent", @data="0.703">, #<CSV::Row location:"Colorado" score:"Reading" timef...

CSV.parse(file, headers: true, header_converters: :symbol)
.map |row| row.to_h
