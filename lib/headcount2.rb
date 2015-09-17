require 'csv'

class DistrictRepository
  attr_reader :path
  def self.from_csv(path)
    @path = path
    rows = CSV.readlines(path + '/Pupil enrollment.csv', headers: true, header_converters: :symbol).map(&:to_h)
    groups = rows.group_by { |row| row.fetch(:location) }
    enrollment_data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    @enrollment_pupil_repo = {}
    # groups.each_pair do |key, value|                                                               # => {"Colorado"=>[{:location=>"Colorado", :timeframe=>"2009", :dataformat=>"Number", :data=>"832368"}, {:location=>"Colorado", :timeframe=>"2010", :dataformat=>"Number", :data=>"843316"}, {:location=>"Colorado", :timeframe=>"2011", :dataformat=>"Number", :data=>"854265"}, {:location=>"Colorado", :timeframe=>"2012", :dataformat=>"Number", :data=>"863561"}, {:location=>"Colorado", :timeframe=>"2013", :dataformat=>"Number", :data=>"876999"}, {:location=>"Colorado", :timeframe=>"2014", :dataformat=>"Number", :data=>"889006"}], "ACADEMY 20"=>[{:location=>"ACADEMY 20", :timeframe=>"2009", :dataformat=>"Number", :data=>"22620"}, {:location=>"ACADEMY 20", :timeframe=>"2010", :dataformat=>"Number", :data=>"23119"}, {:location=>"ACADEMY 20", :timeframe=>"2011", :dataformat=>"Number", :data=>"23657"}, {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Number", :data=>"23973"}, {:locatio...
    #   {key.upcase=>{:enrollment=>{:pupil_data=>{}}, :statewide_testing=>"more shit"}}              # => {"COLORADO"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"ACADEMY 20"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"ADAMS COUNTY 14"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"ADAMS-ARAPAHOE 28J"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"AGATE 300"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"AGUILAR REORGANIZED 6"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"AKRON R-1"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"ALAMOSA RE-11J"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"ARCHULETA COUNTY 50 JT"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"ARICKAREE R-2"=>{:statewide_testing=>{:pupil_data=>{}}, :enrollment=>"more shit"}}, {"ARRIBA-FLAGLER C-20"=>...
    # end                                                                                            # => {"Colorado"=>[{:location=>"Colorado", :timeframe=>"2009", :dataformat=>"Number", :data=>"832368"}, {:location=>"Colorado", :timeframe=>"2010", :dataformat=>"Number", :data=>"843316"}, {:location=>"Colorado", :timeframe=>"2011", :dataformat=>"Number", :data=>"854265"}, {:location=>"Colorado", :timeframe=>"2012", :dataformat=>"Number", :data=>"863561"}, {:location=>"Colorado", :timeframe=>"2013", :dataformat=>"Number", :data=>"876999"}, {:location=>"Colorado", :timeframe=>"2014", :dataformat=>"Number", :data=>"889006"}], "ACADEMY 20"=>[{:location=>"ACADEMY 20", :timeframe=>"2009", :dataformat=>"Number", :data=>"22620"}, {:location=>"ACADEMY 20", :timeframe=>"2010", :dataformat=>"Number", :data=>"23119"}, {:location=>"ACADEMY 20", :timeframe=>"2011", :dataformat=>"Number", :data=>"23657"}, {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Number", :data=>"23973"}, {:locatio...                                                                                              # => {}
    groups.each_pair do |key, value|
      @enrollment_pupil_repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    end
    @enrollment_pupil_repo
    DistrictRepository.new(@enrollment_pupil_repo)# @enrollment_data = DistrictRepository.new(@enrollment_pupil_repo)                                                    # => #<DistrictRepository:0x007fd0aa22eb38 @districts={"COLORADO"=>#<District:0x007fd0ab0c9990 @enrollment=#<Enrollment:0x007fd0ab0c97d8 @annual_enrollment=nil>>, "ACADEMY 20"=>#<District:0x007fd0ab0c9170 @enrollment=#<Enrollment:0x007fd0ab0c8fe0 @annual_enrollment=nil>>, "ADAMS COUNTY 14"=>#<District:0x007fd0ab0c89f0 @enrollment=#<Enrollment:0x007fd0ab0c8860 @annual_enrollment=nil>>, "ADAMS-ARAPAHOE 28J"=>#<District:0x007fd0ab0c8270 @enrollment=#<Enrollment:0x007fd0ab0c80e0 @annual_enrollment=nil>>, "AGATE 300"=>#<District:0x007fd0aa1b7ab0 @enrollment=#<Enrollment:0x007fd0aa1b7920 @annual_enrollment=nil>>, "AGUILAR REORGANIZED 6"=>#<District:0x007fd0aa1b7330 @enrollment=#<Enrollment:0x007fd0aa1b71a0 @annual_enrollment=nil>>, "AKRON R-1"=>#<District:0x007fd0aa1b6bb0 @enrollment=#<Enrollment:0x007fd0aa1b6a20 @annual_enrollment=nil>>, "ALAMOSA RE-11J"=>#<District:0x...
  end

  attr_reader :path

  def initialize(repository_data)
    @districts = repository_data.map { |name, district_data|
      [name, District.new(district_data)]
    }.to_h
    @districts.fetch("COLORADO").class
    # => District
  end

  def find_by_name(name)
    @districts.fetch(name)
  end
end

class District
  attr_reader :path, :annual_enrollment, :enrollment
  def initialize(data)
    data = data
    @enrollment = Enrollment.new(data)
  end

  def enrollment
    @enrollment
  end
end

class Enrollment
  attr_reader :annual_enrollment, :path

  def initialize(data)
    @annual_enrollment = data
  end

  def enrollment
    @enrollment
  end

  def in_year(year)
    annual_enrollment.fetch(year)
  end
end
#
# path =
# dr = DistrictRepository.from_csv('/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data/Pupil enrollment.csv')
# district = dr.find_by_name("COLORADO")
# # => #<District:0x007fda8a02f398
# #     @enrollment=
# #      #<Enrollment:0x007fda8a02f370
# #       @annual_enrollment=
# #        {2009=>832368,
# #         2010=>843316,
# #         2011=>854265,
# #         2012=>863561,
# #         2013=>876999,
# #         2014=>889006}>>
# district
# # => #<District:0x007fda8a02f398
# #     @enrollment=
# #      #<Enrollment:0x007fda8a02f370
# #       @annual_enrollment=
# #        {2009=>832368,
# #         2010=>843316,
# #         2011=>854265,
# #         2012=>863561,
# #         2013=>876999,
# #         2014=>889006}>>
# district.enrollment.in_year(2009)
# # => 832368
