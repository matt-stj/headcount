require 'csv'

class DistrictRepository
  attr_reader :path, :districts

  def self.path
    File.expand_path '../data', __dir__
  end

  def self.from_csv(file)
    rows = CSV.readlines(path + file, headers: true, header_converters: :symbol).map(&:to_h)
    groups = rows.group_by { |row| row.fetch(:location) }
    enrollment_data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    @enrollment_pupil_repo = {}
    groups.each_pair do |key, value|
      @enrollment_pupil_repo[key.upcase] = value.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
    end
    @enrollment_pupil_repo
    DistrictRepository.new(@enrollment_pupil_repo)
  end

  def initialize(repository_data)
    @districts = repository_data.map { |name, district_data|
      [name, District.new(district_data)]
    }.to_h
    @districts.fetch("COLORADO").class
  end

  def find_by_name(name)
    @districts.fetch(name)
  end
end

class District
  attr_reader :annual_enrollment, :enrollment
  def initialize(data)
    data = data
    @enrollment = Enrollment.new(data)
  end

  def enrollment
    @enrollment
  end

end

class Enrollment
  attr_reader :annual_enrollment

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

# dr = DistrictRepository.from_csv('/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data/Pupil enrollment.csv')
# dr.districts
# => {"COLORADO"=>
#      #<District:0x007fe01a042048
#       @enrollment=
#        #<Enrollment:0x007fe01a041ff8
#         @annual_enrollment=
#          {2009=>832368,
#           2010=>843316,
#           2011=>854265,
#           2012=>863561,
#           2013=>876999,
#           2014=>889006}>>,
#     "ACADEMY 20"=>
#      #<District:0x007fe01a041f30
#       @enrollment=
#        #<Enrollment:0x007fe01a041f08
#         @annual_enrollment=
#          {2009=>22620,
#           2010=>23119,
#           2011=>23657,
#           2012=>23973,
#           2013=>24481,
#           2014=>24578}>>,
#     "ADAMS COUNTY 14"=>
#      #<District:0x007fe01a041dc8
#       @enrollment=
#        #<Enrollment:0x007fe01a041da0
#         @annual_enrollment=
#          {2009=>7422,
#           2010=>7549,
#           2011=>7321,
#           2012=>7500,
#           2013=>7598,
#           2014=>7584}>>,
#     "ADAMS-ARAPAHOE 28J"=>
#      #<District:0x007fe01a041cd8
#       @enrollment=
#        #<Enrollment:0x007fe01a041b98
#         @annual_enrollment=
#          {2009=>36967,
#           2010=>38605,
#           2011=>39696,
#           2012=>39835,
#           2013=>40877,
#           2014=>41729}>>,
#     "AGATE 300"=>
#      #<District:0x007fe01a041af8
#       @enrollment=
#        #<Enrollment:0x007fe01a041ad0
#         @annual_enrollment=
#          {2009=>45, 2010=>33, 2011=>9, 2012=>10, 2013=>12, 2014=>10}>>,
#     "AGUILAR REORGANIZED 6"=>
#      #<District:0x007fe01a041990
#       @enrollment=
#        #<Enrollment:0x007fe01a041968
#         @annual_enrollment=
#          {2009=>133, 2010=>112, 2011=>94, 2012=>97, 2013=>107, 2014=>130}>>,
#     "AKRON R-1"=>
#      #<District:0x007fe01a0418c8
#       @enrollment=
#        #<Enrollment:0x007fe01a041850
#         @annual_enrollment=
#          {2009=>384,
#           2010=>381,
#           2011=>359,
#           2012=>354,
#           2013=>358,
#           2014=>357}>>,
#     "ALAMOSA RE-11J"=>
#      #<District:0x007fe01a0416c0
#       @enrollment=
#        #<Enrollment:0x007fe01a041698
#         @annual_enrollment=
#          {2009=>2046,
#           2010=>2081,
#           2011=>2098,
#           2012=>2072,
#           2013=>2046,
#           2014=>2136}>>,
#     "ARCHULETA COUNTY 50 JT"=>
#      #<District:0x007fe01a0415a8
#       @enrollment=
#        #<Enrollment:0x007fe01a041418
#         @annual_enrollment=
#          {2009=>1517,
#           2010=>1492,
#           2011=>1405,
#           2012=>1371,
#           2013=>1323,
#           2014=>1326}>>,
#     "ARICKAREE R-2"=>
#      #<District:0x007fe01a041350
#       @enrollment=
#        #<Enrollment:0x007fe01a0412d8
#         @annual_enrollment=
#          {2009=>113,
#           2010=>111,
#           2011=>104,
#           2012=>108,
#           2013=>114,
#           2014=>107}>>,
#     "ARRIBA-FLAGLER C-20"=>
#      #<District:0x007fe01a041120
#       @enrollment=
#        #<Enrollment:0x007fe01a0410f8
#         @annual_enrollment=
#          {2009=>165,
#           2010=>170,
#           2011=>167,
#           2012=>176,
#           2013=>187,
#           2014=>195}>>,
#     "ASPEN 1"=>
#      #<District:0x007fe01a041058
#       @enrollment=
#        #<Enrollment:0x007fe01a041030
#         @annual_enrollment=
#          {2009=>1698,
#           2010=>1727,
#           2011=>1712,
#           2012=>1732,
#           2013=>1728,
#           2014=>1756}>>,
#     "AULT-HIGHLAND RE-9"=>
#      #<District:0x007fe01a040ef0
#       @enrollment=
#        #<Enrollment:0x007fe01a040ea0
#         @annual_enrollment=
#          {2009=>816,
#           2010=>846,
#           2011=>795,
#           2012=>770,
#           2013=>765,
#           2014=>761}>>,
#     "BAYFIELD 10 JT-R"=>
#      #<District:0x007fe01a040dd8
#       @enrollment=
#        #<Enrollment:0x007fe01a040db0
#         @annual_enrollment=
#          {2009=>1406,
#           2010=>1405,
#           2011=>1362,
#           2012=>1402,
#           2013=>1340,
#           2014=>1325}>>,
#     "BENNETT 29J"=>
#      #<District:0x007fe01a040c48
#       @enrollment=
#        #<Enrollment:0x007fe01a040c20
#         @annual_enrollment=
#          {2009=>1127,
#           2010=>1150,
#           2011=>1085,
#           2012=>1044,
#           2013=>1013,
#           2014=>1079}>>,
#     "BETHUNE R-5"=>
#      #<District:0x007fe01a040a68
#       @enrollment=
#        #<Enrollment:0x007fe01a0409f0
#         @annual_enrollment=
#          {2009=>126,
#           2010=>130,
#           2011=>133,
#           2012=>133,
#           2013=>132,
#           2014=>117}>>,
#     "BIG SANDY 100J"=>
#      #<District:0x007fe01a040950
#       @enrollment=
#        #<Enrollment:0x007fe01a040928
#         @annual_enrollment=
#          {2009=>319,
#           2010=>331,
#           2011=>330,
#           2012=>300,
#           2013=>318,
#           2014=>295}>>,
#     "BOULDER VALLEY RE 2"=>
#      #<District:0x007fe01a040748
#       @enrollment=
#        #<Enrollment:0x007fe01a0406f8
#         @annual_enrollment=
#          {2009=>29011,
#           2010=>29526,
#           2011=>29780,
#           2012=>30041,
#           2013=>30546,
#           2014=>30908}>>,
#     "BRANSON REORGANIZED 82"=>
#      #<District:0x007fe01a040608
#       @enrollment=
#        #<Enrollment:0x007fe01a0404a0
#         @annual_enrollment=
#          {2009=>493,
#           2010=>470,
#           2011=>438,
#           2012=>452,
#           2013=>480,
#           2014=>450}>>,
#     "BRIGGSDALE RE-10"=>
#      #<District:0x007fe01a040360
#       @enrollment=
#        #<Enrollment:0x007fe01a040338
#         @annual_enrollment=
#          {2009=>161,
#           2010=>157,
#           2011=>156,
#           2012=>162,
#           2013=>162,
#           2014=>177}>>,
#     "BRIGHTON 27J"=>
#      #<District:0x007fe01a040220
#       @enrollment=
#        #<Enrollment:0x007fe01a040108
#         @annual_enrollment=
#          {2009=>14469,
#           2010=>15063,
#           2011=>15649,
#           2012=>16163,
#           2013=>16698,
#           2014=>17103}>>,
#     "BRUSH RE-2(J)"=>
#      #<District:0x007fe01a040068
#       @enrollment=
#        #<Enrollment:0x007fe01a040018
#         @annual_enrollment=
#          {2009=>1486,
#           2010=>1510,
#           2011=>1501,
#           2012=>1547,
#           2013=>1564,
#           2014=>1518}>>,
#     "BUENA VISTA R-31"=>
#      #<District:0x007fe01a033ef8
#       @enrollment=
#        #<Enrollment:0x007fe01a033ea8
#         @annual_enrollment=
#          {2009=>969,
#           2010=>985,
#           2011=>1013,
#           2012=>994,
#           2013=>968,
#           2014=>950}>>,
#     "BUFFALO RE-4"=>
#      #<District:0x007fe01a033de0
#       @enrollment=
#        #<Enrollment:0x007fe01a033db8
#         @annual_enrollment=
#          {2009=>306,
#           2010=>311,
#           2011=>309,
#           2012=>319,
#           2013=>318,
#           2014=>315}>>,
#     "BURLINGTON RE-6J"=>
#      #<District:0x007fe01a033c00
#       @enrollment=
#        #<Enrollment:0x007fe01a033b88
#         @annual_enrollment=
#          {2009=>819,
#           2010=>830,
#           2011=>832,
#           2012=>814,
#           2013=>828,
#           2014=>784}>>,
#     "BYERS 32J"=>
#      #<District:0x007fe01a0339f8
#       @enrollment=
#        #<Enrollment:0x007fe01a033958
#         @annual_enrollment=
#          {2009=>480,
#           2010=>473,
#           2011=>494,
#           2012=>563,
#           2013=>647,
#           2014=>2142}>>,
#     "CALHAN RJ-1"=>
#      #<District:0x007fe01a0338b8
#       @enrollment=
#        #<Enrollment:0x007fe01a033890
#         @annual_enrollment=
#          {2009=>639,
#           2010=>620,
#           2011=>526,
#           2012=>510,
#           2013=>472,
#           2014=>463}>>,
#     "CAMPO RE-6"=>
#      #<District:0x007fe01a033700
#       @enrollment=
#        #<Enrollment:0x007fe01a0336d8
#         @annual_enrollment=
#          {2009=>49, 2010=>58, 2011=>57, 2012=>49, 2013=>44, 2014=>44}>>,
#     "CANON CITY RE-1"=>
#      #<District:0x007fe01a033638
#       @enrollment=
#        #<Enrollment:0x007fe01a033548
#         @annual_enrollment=
#          {2009=>3699,
#           2010=>3702,
#           2011=>3738,
#           2012=>3622,
#           2013=>3650,
#           2014=>3603}>>,
#     "CENTENNIAL R-1"=>
#      #<District:0x007fe01a0334a8
#       @enrollment=
#        #<Enrollment:0x007fe01a033480
#         @annual_enrollment=
#          {2009=>220,
#           2010=>248,
#           2011=>248,
#           2012=>190,
#           2013=>208,
#           2014=>221}>>,
#     "CENTER 26 JT"=>
#      #<District:0x007fe01a0333b8
#       @enrollment=
#        #<Enrollment:0x007fe01a0332a0
#         @annual_enrollment=
#          {2009=>605,
#           2010=>580,
#           2011=>612,
#           2012=>623,
#           2013=>657,
#           2014=>649}>>,
#     "CHERAW 31"=>
#      #<District:0x007fe01a0331d8
#       @enrollment=
#        #<Enrollment:0x007fe01a033188
#         @annual_enrollment=
#          {2009=>210,
#           2010=>219,
#           2011=>219,
#           2012=>222,
#           2013=>231,
#           2014=>229}>>,
#     "CHERRY CREEK 5"=>
#      #<District:0x007fe01a033048
#       @enrollment=
#        #<Enrollment:0x007fe01a033020
#         @annual_enrollment=
#          {2009=>51708,
#           2010=>52166,
#           2011=>52589,
#           2012=>53368,
#           2013=>54226,
#           2014=>54499}>>,
#     "CHEYENNE COUNTY RE-5"=>
#      #<District:0x007fe01a032f80
#       @enrollment=
#        #<Enrollment:0x007fe01a032f30
#         @annual_enrollment=
#          {2009=>189,
#           2010=>206,
#           2011=>206,
#           2012=>203,
#           2013=>179,
#           2014=>182}>>,
#     "CHEYENNE MOUNTAIN 12"=>
#      #<District:0x007fe01a032d28
#       @enrollment=
#        #<Enrollment:0x007fe01a032cd8
#         @annual_enrollment=
#          {2009=>4578,
#           2010=>4561,
#           2011=>4612,
#           2012=>4651,
#           2013=>5127,
#           2014=>5148}>>,
#     "CLEAR CREEK RE-1"=>
#      #<District:0x007fe01a032b20
#       @enrollment=
#        #<Enrollment:0x007fe01a032ad0
#         @annual_enrollment=
#          {2009=>974,
#           2010=>989,
#           2011=>993,
#           2012=>959,
#           2013=>930,
#           2014=>890}>>,
#     "COLORADO SPRINGS 11"=>
#      #<District:0x007fe01a032a30
#       @enrollment=
#        #<Enrollment:0x007fe01a032a08
#         @annual_enrollment=
#          {2009=>29641,
#           2010=>29459,
#           2011=>29509,
#           2012=>28993,
#           2013=>28404,
#           2014=>28332}>>,
#     "COTOPAXI RE-3"=>
#      #<District:0x007fe01a032878
#       @enrollment=
#        #<Enrollment:0x007fe01a032828
#         @annual_enrollment=
#          {2009=>224,
#           2010=>222,
#           2011=>205,
#           2012=>220,
#           2013=>211,
#           2014=>221}>>,
#     "CREEDE CONSOLIDATED 1"=>
#      #<District:0x007fe01a032788
#       @enrollment=
#        #<Enrollment:0x007fe01a032760
#         @annual_enrollment=
#          {2009=>101, 2010=>92, 2011=>81, 2012=>78, 2013=>80, 2014=>77}>>,
#     "CRIPPLE CREEK-VICTOR RE-1"=>
#      #<District:0x007fe01a032620
#       @enrollment=
#        #<Enrollment:0x007fe01a0325f8
#         @annual_enrollment=
#          {2009=>469,
#           2010=>441,
#           2011=>404,
#           2012=>377,
#           2013=>379,
#           2014=>384}>>,
#     "CROWLEY COUNTY RE-1-J"=>
#      #<District:0x007fe01a032530
#       @enrollment=
#        #<Enrollment:0x007fe01a032418
#         @annual_enrollment=
#          {2009=>495,
#           2010=>493,
#           2011=>479,
#           2012=>446,
#           2013=>448,
#           2014=>437}>>,
#     "CUSTER COUNTY SCHOOL DISTRICT C-1"=>
#      #<District:0x007fe01a032378
#       @enrollment=
#        #<Enrollment:0x007fe01a032350
#         @annual_enrollment=
#          {2009=>489,
#           2010=>454,
#           2011=>443,
#           2012=>414,
#           2013=>411,
#           2014=>397}>>,
#     "DE BEQUE 49JT"=>
#      #<District:0x007fe01a032210
#       @enrollment=
#        #<Enrollment:0x007fe01a0321e8
#         @annual_enrollment=
#          {2009=>160,
#           2010=>136,
#           2011=>125,
#           2012=>135,
#           2013=>146,
#           2014=>151}>>,
#     "DEER TRAIL 26J"=>
#      #<District:0x007fe01a032148
#       @enrollment=
#        #<Enrollment:0x007fe01a0320d0
#         @annual_enrollment=
#          {2009=>165,
#           2010=>167,
#           2011=>178,
#           2012=>185,
#           2013=>176,
#           2014=>184}>>,
#     "DEL NORTE C-7"=>
#      #<District:0x007fe01a031ea0
#       @enrollment=
#        #<Enrollment:0x007fe01a031e78
#         @annual_enrollment=
#          {2009=>597,
#           2010=>567,
#           2011=>522,
#           2012=>475,
#           2013=>443,
#           2014=>417}>>,
#     "DELTA COUNTY 50(J)"=>
#      #<District:0x007fe01a031d88
#       @enrollment=
#        #<Enrollment:0x007fe01a031c70
#         @annual_enrollment=
#          {2009=>5337,
#           2010=>5301,
#           2011=>5284,
#           2012=>5355,
#           2013=>5062,
#           2014=>5075}>>,
#     "DENVER COUNTY 1"=>
#      #<District:0x007fe01a031bd0
#       @enrollment=
#        #<Enrollment:0x007fe01a031b80
#         @annual_enrollment=
#          {2009=>77255,
#           2010=>78317,
#           2011=>80890,
#           2012=>83377,
#           2013=>86043,
#           2014=>88839}>>,
#     "DOLORES COUNTY RE NO.2"=>
#      #<District:0x007fe01a0319f0
#       @enrollment=
#        #<Enrollment:0x007fe01a0319c8
#         @annual_enrollment=
#          {2009=>291,
#           2010=>309,
#           2011=>293,
#           2012=>288,
#           2013=>293,
#           2014=>269}>>,
#     "DOLORES RE-4A"=>
#      #<District:0x007fe01a031900
#       @enrollment=
#        #<Enrollment:0x007fe01a0318d8
#         @annual_enrollment=
#          {2009=>710,
#           2010=>689,
#           2011=>722,
#           2012=>784,
#           2013=>775,
#           2014=>796}>>,
#     "DOUGLAS COUNTY RE 1"=>
#      #<District:0x007fe01a031798
#       @enrollment=
#        #<Enrollment:0x007fe01a031748
#         @annual_enrollment=
#          {2009=>59932,
#           2010=>61465,
#           2011=>63114,
#           2012=>64657,
#           2013=>66230,
#           2014=>66702}>>,
#     "DURANGO 9-R"=>
#      #<District:0x007fe01a031658
#       @enrollment=
#        #<Enrollment:0x007fe01a031630
#         @annual_enrollment=
#          {2009=>4697,
#           2010=>4675,
#           2011=>4537,
#           2012=>4575,
#           2013=>4659,
#           2014=>4564}>>,
#     "EADS RE-1"=>
#      #<District:0x007fe01a0314a0
#       @enrollment=
#        #<Enrollment:0x007fe01a031478
#         @annual_enrollment=
#          {2009=>189,
#           2010=>187,
#           2011=>185,
#           2012=>180,
#           2013=>181,
#           2014=>175}>>,
#     "EAGLE COUNTY RE 50"=>
#      #<District:0x007fe01a031338
#       @enrollment=
#        #<Enrollment:0x007fe01a0312e8
#         @annual_enrollment=
#          {2009=>6244,
#           2010=>6181,
#           2011=>6344,
#           2012=>6408,
#           2013=>6520,
#           2014=>6713}>>,
#     "EAST GRAND 2"=>
#      #<District:0x007fe01a031248
#       @enrollment=
#        #<Enrollment:0x007fe01a031220
#         @annual_enrollment=
#          {2009=>1438,
#           2010=>1325,
#           2011=>1273,
#           2012=>1245,
#           2013=>1264,
#           2014=>1299}>>,
#     "EAST OTERO R-1"=>
#      #<District:0x007fe01a030fc8
#       @enrollment=
#        #<Enrollment:0x007fe01a030fa0
#         @annual_enrollment=
#          {2009=>1318,
#           2010=>1309,
#           2011=>1293,
#           2012=>1307,
#           2013=>1309,
#           2014=>1309}>>,
#     "EAST YUMA COUNTY RJ-2"=>
#      #<District:0x007fe01a030e88
#       @enrollment=
#        #<Enrollment:0x007fe01a030d20
#         @annual_enrollment=
#          {2009=>0, 2010=>0, 2011=>0, 2012=>0, 2013=>0, 2014=>0}>>,
#     "EATON RE-2"=>
#      #<District:0x007fe01a030c80
#       @enrollment=
#        #<Enrollment:0x007fe01a030c58
#         @annual_enrollment=
#          {2009=>1705,
#           2010=>1749,
#           2011=>1768,
#           2012=>1804,
#           2013=>1837,
#           2014=>1904}>>,
#     "EDISON 54 JT"=>
#      #<District:0x007fe01a030b68
#       @enrollment=
#        #<Enrollment:0x007fe01a030a78
#         @annual_enrollment=
#          {2009=>305,
#           2010=>214,
#           2011=>190,
#           2012=>185,
#           2013=>191,
#           2014=>217}>>,
#     "ELBERT 200"=>
#      #<District:0x007fe01a0309b0
#       @enrollment=
#        #<Enrollment:0x007fe01a030960
#         @annual_enrollment=
#          {2009=>239,
#           2010=>230,
#           2011=>199,
#           2012=>209,
#           2013=>198,
#           2014=>221}>>,
#     "ELIZABETH C-1"=>
#      #<District:0x007fe01a030820
#       @enrollment=
#        #<Enrollment:0x007fe01a0307f8
#         @annual_enrollment=
#          {2009=>2737,
#           2010=>2636,
#           2011=>2656,
#           2012=>2703,
#           2013=>2621,
#           2014=>2545}>>,
#     "ELLICOTT 22"=>
#      #<District:0x007fe01a030758
#       @enrollment=
#        #<Enrollment:0x007fe01a030708
#         @annual_enrollment=
#          {2009=>896,
#           2010=>1003,
#           2011=>1003,
#           2012=>1027,
#           2013=>955,
#           2014=>1072}>>,
#     "ENGLEWOOD 1"=>
#      #<District:0x007fe01a0305a0
#       @enrollment=
#        #<Enrollment:0x007fe01a030550
#         @annual_enrollment=
#          {2009=>3124,
#           2010=>2992,
#           2011=>2954,
#           2012=>2981,
#           2013=>2835,
#           2014=>2866}>>,
#     "FALCON 49"=>
#      #<District:0x007fe01a030410
#       @enrollment=
#        #<Enrollment:0x007fe01a0303e8
#         @annual_enrollment=
#          {2009=>14398,
#           2010=>14708,
#           2011=>15063,
#           2012=>15478,
#           2013=>18880,
#           2014=>19552}>>,
#     "FLORENCE RE-2"=>
#      #<District:0x007fe01a030348
#       @enrollment=
#        #<Enrollment:0x007fe01a030320
#         @annual_enrollment=
#          {2009=>1623,
#           2010=>1600,
#           2011=>0,
#           2012=>1536,
#           2013=>1450,
#           2014=>1373}>>,
#     "FORT MORGAN RE-3"=>
#      #<District:0x007fe01a030140
#       @enrollment=
#        #<Enrollment:0x007fe01a0300a0
#         @annual_enrollment=
#          {2009=>3232,
#           2010=>3204,
#           2011=>3194,
#           2012=>3153,
#           2013=>3205,
#           2014=>3200}>>,
#     "FOUNTAIN 8"=>
#      #<District:0x007fe01a083de0
#       @enrollment=
#        #<Enrollment:0x007fe01a083db8
#         @annual_enrollment=
#          {2009=>7365,
#           2010=>7536,
#           2011=>7702,
#           2012=>7840,
#           2013=>8089,
#           2014=>8120}>>,
#     "FOWLER R-4J"=>
#      #<District:0x007fe01a083cc8
#       @enrollment=
#        #<Enrollment:0x007fe01a083bd8
#         @annual_enrollment=
#          {2009=>402,
#           2010=>421,
#           2011=>407,
#           2012=>409,
#           2013=>409,
#           2014=>402}>>,
#     "FRENCHMAN RE-3"=>
#      #<District:0x007fe01a083b10
#       @enrollment=
#        #<Enrollment:0x007fe01a083ae8
#         @annual_enrollment=
#          {2009=>188,
#           2010=>200,
#           2011=>185,
#           2012=>202,
#           2013=>203,
#           2014=>198}>>,
#     "GARFIELD 16"=>
#      #<District:0x007fe01a0825f8
#       @enrollment=
#        #<Enrollment:0x007fe01a082508
#         @annual_enrollment=
#          {2009=>1229,
#           2010=>1133,
#           2011=>1176,
#           2012=>1126,
#           2013=>1050,
#           2014=>1038}>>,
#     "GARFIELD RE-2"=>
#      #<District:0x007fe01a082468
#       @enrollment=
#        #<Enrollment:0x007fe01a082418
#         @annual_enrollment=
#          {2009=>4935,
#           2010=>4980,
#           2011=>4717,
#           2012=>4730,
#           2013=>4818,
#           2014=>4828}>>,
#     "GENOA-HUGO C113"=>
#      #<District:0x007fe01a0821e8
#       @enrollment=
#        #<Enrollment:0x007fe01a0821c0
#         @annual_enrollment=
#          {2009=>190,
#           2010=>178,
#           2011=>185,
#           2012=>176,
#           2013=>178,
#           2014=>171}>>,
#     "GILPIN COUNTY RE-1"=>
#      #<District:0x007fe01a082120
#       @enrollment=
#        #<Enrollment:0x007fe01a0820d0
#         @annual_enrollment=
#          {2009=>361,
#           2010=>386,
#           2011=>380,
#           2012=>373,
#           2013=>421,
#           2014=>429}>>,
#     "GRANADA RE-1"=>
#      #<District:0x007fe01a081f18
#       @enrollment=
#        #<Enrollment:0x007fe01a081ec8
#         @annual_enrollment=
#          {2009=>243,
#           2010=>244,
#           2011=>247,
#           2012=>218,
#           2013=>202,
#           2014=>202}>>,
#     "GREELEY 6"=>
#      #<District:0x007fe01a081e28
#       @enrollment=
#        #<Enrollment:0x007fe01a081e00
#         @annual_enrollment=
#          {2009=>19117,
#           2010=>19623,
#           2011=>19840,
#           2012=>19821,
#           2013=>20450,
#           2014=>21183}>>,
#     "GUNNISON WATERSHED RE1J"=>
#      #<District:0x007fe01a081c70
#       @enrollment=
#        #<Enrollment:0x007fe01a081c48
#         @annual_enrollment=
#          {2009=>1818,
#           2010=>1864,
#           2011=>1846,
#           2012=>1846,
#           2013=>1934,
#           2014=>1929}>>,
#     "HANOVER 28"=>
#      #<District:0x007fe01a081900
#       @enrollment=
#        #<Enrollment:0x007fe01a0817e8
#         @annual_enrollment=
#          {2009=>266,
#           2010=>223,
#           2011=>208,
#           2012=>227,
#           2013=>251,
#           2014=>260}>>,
#     "HARRISON 2"=>
#      #<District:0x007fe01a081748
#       @enrollment=
#        #<Enrollment:0x007fe01a081720
#         @annual_enrollment=
#          {2009=>11309,
#           2010=>11147,
#           2011=>11108,
#           2012=>10775,
#           2013=>11179,
#           2014=>11441}>>,
#     "HAXTUN RE-2J"=>
#      #<District:0x007fe01a0813d8
#       @enrollment=
#        #<Enrollment:0x007fe01a0813b0
#         @annual_enrollment=
#          {2009=>317,
#           2010=>323,
#           2011=>323,
#           2012=>331,
#           2013=>326,
#           2014=>330}>>,
#     "HAYDEN RE-1"=>
#      #<District:0x007fe01a081310
#       @enrollment=
#        #<Enrollment:0x007fe01a0812c0
#         @annual_enrollment=
#          {2009=>438,
#           2010=>420,
#           2011=>389,
#           2012=>406,
#           2013=>415,
#           2014=>414}>>,
#     "HINSDALE COUNTY RE 1"=>
#      #<District:0x007fe01a081130
#       @enrollment=
#        #<Enrollment:0x007fe01a081108
#         @annual_enrollment=
#          {2009=>93, 2010=>96, 2011=>91, 2012=>81, 2013=>80, 2014=>96}>>,
#     "HI-PLAINS R-23"=>
#      #<District:0x007fe01a081068
#       @enrollment=
#        #<Enrollment:0x007fe01a081040
#         @annual_enrollment=
#          {2009=>122,
#           2010=>107,
#           2011=>129,
#           2012=>131,
#           2013=>121,
#           2014=>111}>>,
#     "HOEHNE REORGANIZED 3"=>
#      #<District:0x007fe01a080f00
#       @enrollment=
#        #<Enrollment:0x007fe01a080eb0
#         @annual_enrollment=
#          {2009=>329,
#           2010=>334,
#           2011=>351,
#           2012=>385,
#           2013=>359,
#           2014=>363}>>,
#     "HOLLY RE-3"=>
#      #<District:0x007fe01a080de8
#       @enrollment=
#        #<Enrollment:0x007fe01a080cf8
#         @annual_enrollment=
#          {2009=>291,
#           2010=>292,
#           2011=>294,
#           2012=>292,
#           2013=>299,
#           2014=>302}>>,
#     "HOLYOKE RE-1J"=>
#      #<District:0x007fe01a080c58
#       @enrollment=
#        #<Enrollment:0x007fe01a080c30
#         @annual_enrollment=
#          {2009=>631,
#           2010=>614,
#           2011=>633,
#           2012=>630,
#           2013=>568,
#           2014=>593}>>,
#     "HUERFANO RE-1"=>
#      #<District:0x007fe01a080af0
#       @enrollment=
#        #<Enrollment:0x007fe01a080a28
#         @annual_enrollment=
#          {2009=>620,
#           2010=>575,
#           2011=>554,
#           2012=>520,
#           2013=>511,
#           2014=>537}>>,
#     "IDALIA SCHOOL DISTRICT RJ-3"=>
#      #<District:0x007fe01a080910
#       @enrollment=
#        #<Enrollment:0x007fe01a080870
#         @annual_enrollment=
#          {2009=>162,
#           2010=>157,
#           2011=>161,
#           2012=>186,
#           2013=>182,
#           2014=>201}>>,
#     "IGNACIO 11 JT"=>
#      #<District:0x007fe01a080690
#       @enrollment=
#        #<Enrollment:0x007fe01a080668
#         @annual_enrollment=
#          {2009=>797,
#           2010=>751,
#           2011=>759,
#           2012=>718,
#           2013=>763,
#           2014=>791}>>,
#     "JEFFERSON COUNTY R-1"=>
#      #<District:0x007fe01a0805a0
#       @enrollment=
#        #<Enrollment:0x007fe01a0804b0
#         @annual_enrollment=
#          {2009=>86250,
#           2010=>85938,
#           2011=>85751,
#           2012=>85508,
#           2013=>85983,
#           2014=>86547}>>,
#     "JOHNSTOWN-MILLIKEN RE-5J"=>
#      #<District:0x007fe01a0803e8
#       @enrollment=
#        #<Enrollment:0x007fe01a080398
#         @annual_enrollment=
#          {2009=>3136,
#           2010=>3138,
#           2011=>3271,
#           2012=>3363,
#           2013=>3548,
#           2014=>3732}>>,
#     "JULESBURG RE-1"=>
#      #<District:0x007fe01a0801e0
#       @enrollment=
#        #<Enrollment:0x007fe01a0801b8
#         @annual_enrollment=
#          {2009=>1237,
#           2010=>1787,
#           2011=>888,
#           2012=>1154,
#           2013=>955,
#           2014=>794}>>,
#     "KARVAL RE-23"=>
#      #<District:0x007fe01a080118
#       @enrollment=
#        #<Enrollment:0x007fe01a0800c8
#         @annual_enrollment=
#          {2009=>273, 2010=>235, 2011=>194, 2012=>122, 2013=>100, 2014=>45}>>,
#     "KEENESBURG RE-3(J)"=>
#      #<District:0x007fe01a073f58
#       @enrollment=
#        #<Enrollment:0x007fe01a073e18
#         @annual_enrollment=
#          {2009=>2149,
#           2010=>2276,
#           2011=>2276,
#           2012=>2313,
#           2013=>2306,
#           2014=>2386}>>,
#     "KIM REORGANIZED 88"=>
#      #<District:0x007fe01a073d78
#       @enrollment=
#        #<Enrollment:0x007fe01a073d50
#         @annual_enrollment=
#          {2009=>61, 2010=>58, 2011=>57, 2012=>51, 2013=>46, 2014=>48}>>,
#     "KIOWA C-2"=>
#      #<District:0x007fe01a073c88
#       @enrollment=
#        #<Enrollment:0x007fe01a073b98
#         @annual_enrollment=
#          {2009=>383,
#           2010=>371,
#           2011=>393,
#           2012=>383,
#           2013=>344,
#           2014=>287}>>,
#     "KIT CARSON R-1"=>
#      #<District:0x007fe01a073ad0
#       @enrollment=
#        #<Enrollment:0x007fe01a073a58
#         @annual_enrollment=
#          {2009=>96, 2010=>109, 2011=>120, 2012=>110, 2013=>114, 2014=>108}>>,
#     "LA VETA RE-2"=>
#      #<District:0x007fe01a073918
#       @enrollment=
#        #<Enrollment:0x007fe01a0738f0
#         @annual_enrollment=
#          {2009=>254,
#           2010=>223,
#           2011=>225,
#           2012=>226,
#           2013=>191,
#           2014=>215}>>,
#     "LAKE COUNTY R-1"=>
#      #<District:0x007fe01a073850
#       @enrollment=
#        #<Enrollment:0x007fe01a073800
#         @annual_enrollment=
#          {2009=>1208,
#           2010=>1188,
#           2011=>1224,
#           2012=>1167,
#           2013=>1110,
#           2014=>1093}>>,
#     "LAMAR RE-2"=>
#      #<District:0x007fe01a073670
#       @enrollment=
#        #<Enrollment:0x007fe01a073620
#         @annual_enrollment=
#          {2009=>1718,
#           2010=>1666,
#           2011=>1667,
#           2012=>1672,
#           2013=>1664,
#           2014=>1606}>>,
#     "LAS ANIMAS RE-1"=>
#      #<District:0x007fe01a073490
#       @enrollment=
#        #<Enrollment:0x007fe01a073468
#         @annual_enrollment=
#          {2009=>592,
#           2010=>547,
#           2011=>539,
#           2012=>523,
#           2013=>492,
#           2014=>501}>>,
#     "LEWIS-PALMER 38"=>
#      #<District:0x007fe01a073350
#       @enrollment=
#        #<Enrollment:0x007fe01a073328
#         @annual_enrollment=
#          {2009=>5950,
#           2010=>5977,
#           2011=>6076,
#           2012=>6153,
#           2013=>6275,
#           2014=>6207}>>,
#     "LIBERTY SCHOOL DISTRICT J-4"=>
#      #<District:0x007fe01a072ef0
#       @enrollment=
#        #<Enrollment:0x007fe01a072e28
#         @annual_enrollment=
#          {2009=>89, 2010=>86, 2011=>83, 2012=>80, 2013=>69, 2014=>80}>>,
#     "LIMON RE-4J"=>
#      #<District:0x007fe01a072d10
#       @enrollment=
#        #<Enrollment:0x007fe01a072ce8
#         @annual_enrollment=
#          {2009=>448,
#           2010=>435,
#           2011=>451,
#           2012=>447,
#           2013=>473,
#           2014=>476}>>,
#     "LITTLETON 6"=>
#      #<District:0x007fe01a072798
#       @enrollment=
#        #<Enrollment:0x007fe01a072770
#         @annual_enrollment=
#          {2009=>15753,
#           2010=>15733,
#           2011=>15571,
#           2012=>15754,
#           2013=>15830,
#           2014=>15691}>>,
#     "LONE STAR 101"=>
#      #<District:0x007fe01a072680
#       @enrollment=
#        #<Enrollment:0x007fe01a072568
#         @annual_enrollment=
#          {2009=>118,
#           2010=>104,
#           2011=>112,
#           2012=>116,
#           2013=>121,
#           2014=>106}>>,
#     "MANCOS RE-6"=>
#      #<District:0x007fe01a0724c8
#       @enrollment=
#        #<Enrollment:0x007fe01a0724a0
#         @annual_enrollment=
#          {2009=>373,
#           2010=>369,
#           2011=>374,
#           2012=>396,
#           2013=>416,
#           2014=>455}>>,
#     "MANITOU SPRINGS 14"=>
#      #<District:0x007fe01a072338
#       @enrollment=
#        #<Enrollment:0x007fe01a0722e8
#         @annual_enrollment=
#          {2009=>1405,
#           2010=>1418,
#           2011=>1510,
#           2012=>1500,
#           2013=>1480,
#           2014=>1458}>>,
#     "MANZANOLA 3J"=>
#      #<District:0x007fe01a072220
#       @enrollment=
#        #<Enrollment:0x007fe01a0721a8
#         @annual_enrollment=
#          {2009=>177,
#           2010=>173,
#           2011=>163,
#           2012=>131,
#           2013=>137,
#           2014=>147}>>,
#     "MAPLETON 1"=>
#      #<District:0x007fe01a072040
#       @enrollment=
#        #<Enrollment:0x007fe01a072018
#         @annual_enrollment=
#          {2009=>5775,
#           2010=>7634,
#           2011=>7760,
#           2012=>8051,
#           2013=>8408,
#           2014=>8670}>>,
#     "MC CLAVE RE-2"=>
#      #<District:0x007fe01a071f78
#       @enrollment=
#        #<Enrollment:0x007fe01a071eb0
#         @annual_enrollment=
#          {2009=>259,
#           2010=>305,
#           2011=>293,
#           2012=>272,
#           2013=>266,
#           2014=>279}>>,
#     "MEEKER RE1"=>
#      #<District:0x007fe01a071e10
#       @enrollment=
#        #<Enrollment:0x007fe01a071dc0
#         @annual_enrollment=
#          {2009=>707,
#           2010=>667,
#           2011=>715,
#           2012=>699,
#           2013=>710,
#           2014=>697}>>,
#     "MESA COUNTY VALLEY 51"=>
#      #<District:0x007fe01a071b40
#       @enrollment=
#        #<Enrollment:0x007fe01a071b18
#         @annual_enrollment=
#          {2009=>22030,
#           2010=>22091,
#           2011=>21917,
#           2012=>21730,
#           2013=>21894,
#           2014=>21742}>>,
#     "MIAMI/YODER 60 JT"=>
#      #<District:0x007fe01a071a00
#       @enrollment=
#        #<Enrollment:0x007fe01a0719d8
#         @annual_enrollment=
#          {2009=>329,
#           2010=>320,
#           2011=>316,
#           2012=>268,
#           2013=>307,
#           2014=>278}>>,
#     "MOFFAT 2"=>
#      #<District:0x007fe01a071898
#       @enrollment=
#        #<Enrollment:0x007fe01a071820
#         @annual_enrollment=
#          {2009=>223,
#           2010=>206,
#           2011=>216,
#           2012=>210,
#           2013=>189,
#           2014=>196}>>,
#     "MOFFAT COUNTY RE:NO 1"=>
#      #<District:0x007fe01a071730
#       @enrollment=
#        #<Enrollment:0x007fe01a071708
#         @annual_enrollment=
#          {2009=>2536,
#           2010=>2402,
#           2011=>2299,
#           2012=>2280,
#           2013=>2241,
#           2014=>2175}>>,
#     "MONTE VISTA C-8"=>
#      #<District:0x007fe01a0715a0
#       @enrollment=
#        #<Enrollment:0x007fe01a071578
#         @annual_enrollment=
#          {2009=>1181,
#           2010=>1172,
#           2011=>1198,
#           2012=>1139,
#           2013=>1128,
#           2014=>1130}>>,
#     "MONTEZUMA-CORTEZ RE-1"=>
#      #<District:0x007fe01a071438
#       @enrollment=
#        #<Enrollment:0x007fe01a0713e8
#         @annual_enrollment=
#          {2009=>2946,
#           2010=>2929,
#           2011=>2830,
#           2012=>2753,
#           2013=>2837,
#           2014=>2787}>>,
#     "MONTROSE COUNTY RE-1J"=>
#      #<District:0x007fe01a071320
#       @enrollment=
#        #<Enrollment:0x007fe01a0712f8
#         @annual_enrollment=
#          {2009=>6521,
#           2010=>6415,
#           2011=>6294,
#           2012=>6183,
#           2013=>6200,
#           2014=>6087}>>,
#     "MOUNTAIN VALLEY RE 1"=>
#      #<District:0x007fe01a0710f0
#       @enrollment=
#        #<Enrollment:0x007fe01a0710c8
#         @annual_enrollment=
#          {2009=>128,
#           2010=>120,
#           2011=>121,
#           2012=>120,
#           2013=>135,
#           2014=>138}>>,
#     "NORTH CONEJOS RE-1J"=>
#      #<District:0x007fe01a070fd8
#       @enrollment=
#        #<Enrollment:0x007fe01a070df8
#         @annual_enrollment=
#          {2009=>1051,
#           2010=>1030,
#           2011=>992,
#           2012=>1033,
#           2013=>1005,
#           2014=>964}>>,
#     "NORTH PARK R-1"=>
#      #<District:0x007fe01a070d30
#       @enrollment=
#        #<Enrollment:0x007fe01a070ce0
#         @annual_enrollment=
#          {2009=>230,
#           2010=>211,
#           2011=>196,
#           2012=>206,
#           2013=>213,
#           2014=>190}>>,
#     "NORTHGLENN-THORNTON 12"=>
#      #<District:0x007fe01a070c18
#       @enrollment=
#        #<Enrollment:0x007fe01a070b28
#         @annual_enrollment=
#          {2009=>41949,
#           2010=>41957,
#           2011=>0,
#           2012=>43268,
#           2013=>42230,
#           2014=>38701}>>,
#     "NORWOOD R-2J"=>
#      #<District:0x007fe01a070a88
#       @enrollment=
#        #<Enrollment:0x007fe01a070a38
#         @annual_enrollment=
#          {2009=>274,
#           2010=>257,
#           2011=>280,
#           2012=>275,
#           2013=>272,
#           2014=>287}>>,
#     "OTIS R-3"=>
#      #<District:0x007fe01a0708a8
#       @enrollment=
#        #<Enrollment:0x007fe01a070880
#         @annual_enrollment=
#          {2009=>201,
#           2010=>209,
#           2011=>191,
#           2012=>200,
#           2013=>205,
#           2014=>226}>>,
#     "OURAY R-1"=>
#      #<District:0x007fe01a0707e0
#       @enrollment=
#        #<Enrollment:0x007fe01a070790
#         @annual_enrollment=
#          {2009=>230,
#           2010=>216,
#           2011=>194,
#           2012=>184,
#           2013=>197,
#           2014=>191}>>,
#     "PARK (ESTES PARK) R-3"=>
#      #<District:0x007fe01a070628
#       @enrollment=
#        #<Enrollment:0x007fe01a0705d8
#         @annual_enrollment=
#          {2009=>1210,
#           2010=>1159,
#           2011=>1175,
#           2012=>1139,
#           2013=>1096,
#           2014=>1127}>>,
#     "PARK COUNTY RE-2"=>
#      #<District:0x007fe01a070448
#       @enrollment=
#        #<Enrollment:0x007fe01a070420
#         @annual_enrollment=
#          {2009=>605,
#           2010=>601,
#           2011=>571,
#           2012=>581,
#           2013=>590,
#           2014=>651}>>,
#     "PAWNEE RE-12"=>
#      #<District:0x007fe01a070380
#       @enrollment=
#        #<Enrollment:0x007fe01a070358
#         @annual_enrollment=
#          {2009=>92, 2010=>75, 2011=>91, 2012=>88, 2013=>88, 2014=>81}>>,
#     "PEYTON 23 JT"=>
#      #<District:0x007fe01a0700b0
#       @enrollment=
#        #<Enrollment:0x007fe01a070038
#         @annual_enrollment=
#          {2009=>694,
#           2010=>694,
#           2011=>654,
#           2012=>656,
#           2013=>606,
#           2014=>622}>>,
#     "PLAINVIEW RE-2"=>
#      #<District:0x007fe01a063ef0
#       @enrollment=
#        #<Enrollment:0x007fe01a063ec8
#         @annual_enrollment=
#          {2009=>83, 2010=>85, 2011=>90, 2012=>80, 2013=>72, 2014=>66}>>,
#     "PLATEAU RE-5"=>
#      #<District:0x007fe01a063d88
#       @enrollment=
#        #<Enrollment:0x007fe01a063d60
#         @annual_enrollment=
#          {2009=>163,
#           2010=>176,
#           2011=>182,
#           2012=>197,
#           2013=>196,
#           2014=>177}>>,
#     "PLATEAU VALLEY 50"=>
#      #<District:0x007fe01a063c98
#       @enrollment=
#        #<Enrollment:0x007fe01a063b58
#         @annual_enrollment=
#          {2009=>489,
#           2010=>471,
#           2011=>489,
#           2012=>508,
#           2013=>450,
#           2014=>459}>>,
#     "PLATTE CANYON 1"=>
#      #<District:0x007fe01a063ab8
#       @enrollment=
#        #<Enrollment:0x007fe01a063a90
#         @annual_enrollment=
#          {2009=>1248,
#           2010=>1209,
#           2011=>1092,
#           2012=>1089,
#           2013=>1031,
#           2014=>1017}>>,
#     "PLATTE VALLEY RE-3"=>
#      #<District:0x007fe01a063950
#       @enrollment=
#        #<Enrollment:0x007fe01a063928
#         @annual_enrollment=
#          {2009=>115,
#           2010=>120,
#           2011=>121,
#           2012=>114,
#           2013=>109,
#           2014=>106}>>,
#     "PLATTE VALLEY RE-7"=>
#      #<District:0x007fe01a063888
#       @enrollment=
#        #<Enrollment:0x007fe01a0637c0
#         @annual_enrollment=
#          {2009=>1122,
#           2010=>1057,
#           2011=>1086,
#           2012=>1047,
#           2013=>1094,
#           2014=>1129}>>,
#     "POUDRE R-1"=>
#      #<District:0x007fe01a063590
#       @enrollment=
#        #<Enrollment:0x007fe01a063540
#         @annual_enrollment=
#          {2009=>26520,
#           2010=>26923,
#           2011=>27510,
#           2012=>27909,
#           2013=>28439,
#           2014=>29053}>>,
#     "PRAIRIE RE-11"=>
#      #<District:0x007fe01a0634a0
#       @enrollment=
#        #<Enrollment:0x007fe01a0633d8
#         @annual_enrollment=
#          {2009=>167,
#           2010=>174,
#           2011=>171,
#           2012=>181,
#           2013=>196,
#           2014=>190}>>,
#     "PRIMERO REORGANIZED 2"=>
#      #<District:0x007fe01a063310
#       @enrollment=
#        #<Enrollment:0x007fe01a063298
#         @annual_enrollment=
#          {2009=>231,
#           2010=>221,
#           2011=>189,
#           2012=>198,
#           2013=>196,
#           2014=>197}>>,
#     "PRITCHETT RE-3"=>
#      #<District:0x007fe01a0630e0
#       @enrollment=
#        #<Enrollment:0x007fe01a0630b8
#         @annual_enrollment=
#          {2009=>72, 2010=>66, 2011=>76, 2012=>47, 2013=>53, 2014=>37}>>,
#     "PUEBLO CITY 60"=>
#      #<District:0x007fe01a063018
#       @enrollment=
#        #<Enrollment:0x007fe01a062ff0
#         @annual_enrollment=
#          {2009=>18304,
#           2010=>18420,
#           2011=>17877,
#           2012=>17692,
#           2013=>17990,
#           2014=>17960}>>,
#     "PUEBLO COUNTY RURAL 70"=>
#      #<District:0x007fe01a062eb0
#       @enrollment=
#        #<Enrollment:0x007fe01a062e60
#         @annual_enrollment=
#          {2009=>8929,
#           2010=>8836,
#           2011=>8971,
#           2012=>9107,
#           2013=>9257,
#           2014=>9310}>>,
#     "RANGELY RE-4"=>
#      #<District:0x007fe01a062d98
#       @enrollment=
#        #<Enrollment:0x007fe01a062d70
#         @annual_enrollment=
#          {2009=>505,
#           2010=>480,
#           2011=>525,
#           2012=>561,
#           2013=>555,
#           2014=>542}>>,
#     "RIDGWAY R-2"=>
#      #<District:0x007fe01a062c08
#       @enrollment=
#        #<Enrollment:0x007fe01a062be0
#         @annual_enrollment=
#          {2009=>380,
#           2010=>350,
#           2011=>366,
#           2012=>336,
#           2013=>343,
#           2014=>356}>>,
#     "ROARING FORK RE-1"=>
#      #<District:0x007fe01a062938
#       @enrollment=
#        #<Enrollment:0x007fe01a0628e8
#         @annual_enrollment=
#          {2009=>5344,
#           2010=>5212,
#           2011=>5382,
#           2012=>5436,
#           2013=>5628,
#           2014=>5613}>>,
#     "ROCKY FORD R-2"=>
#      #<District:0x007fe01a0627f8
#       @enrollment=
#        #<Enrollment:0x007fe01a0627d0
#         @annual_enrollment=
#          {2009=>878,
#           2010=>862,
#           2011=>877,
#           2012=>825,
#           2013=>805,
#           2014=>809}>>,
#     "SALIDA R-32"=>
#      #<District:0x007fe01a062640
#       @enrollment=
#        #<Enrollment:0x007fe01a062618
#         @annual_enrollment=
#          {2009=>1085,
#           2010=>1071,
#           2011=>1102,
#           2012=>1156,
#           2013=>1176,
#           2014=>1194}>>,
#     "SANFORD 6J"=>
#      #<District:0x007fe01a062578
#       @enrollment=
#        #<Enrollment:0x007fe01a062488
#         @annual_enrollment=
#          {2009=>340,
#           2010=>346,
#           2011=>354,
#           2012=>360,
#           2013=>395,
#           2014=>391}>>,
#     "SANGRE DE CRISTO RE-22J"=>
#      #<District:0x007fe01a0623e8
#       @enrollment=
#        #<Enrollment:0x007fe01a0623c0
#         @annual_enrollment=
#          {2009=>323,
#           2010=>312,
#           2011=>310,
#           2012=>316,
#           2013=>324,
#           2014=>337}>>,
#     "SARGENT RE-33J"=>
#      #<District:0x007fe01a0622f8
#       @enrollment=
#        #<Enrollment:0x007fe01a062208
#         @annual_enrollment=
#          {2009=>484,
#           2010=>478,
#           2011=>453,
#           2012=>449,
#           2013=>447,
#           2014=>424}>>,
#     "SHERIDAN 2"=>
#      #<District:0x007fe01a062168
#       @enrollment=
#        #<Enrollment:0x007fe01a062118
#         @annual_enrollment=
#          {2009=>1595,
#           2010=>1653,
#           2011=>1641,
#           2012=>1584,
#           2013=>1583,
#           2014=>1536}>>,
#     "SIERRA GRANDE R-30"=>
#      #<District:0x007fe01a061fd8
#       @enrollment=
#        #<Enrollment:0x007fe01a061fb0
#         @annual_enrollment=
#          {2009=>252,
#           2010=>260,
#           2011=>268,
#           2012=>270,
#           2013=>256,
#           2014=>254}>>,
#     "SILVERTON 1"=>
#      #<District:0x007fe01a061f10
#       @enrollment=
#        #<Enrollment:0x007fe01a061e70
#         @annual_enrollment=
#          {2009=>66, 2010=>65, 2011=>65, 2012=>62, 2013=>64, 2014=>62}>>,
#     "SOUTH CONEJOS RE-10"=>
#      #<District:0x007fe01a061c18
#       @enrollment=
#        #<Enrollment:0x007fe01a061ba0
#         @annual_enrollment=
#          {2009=>280,
#           2010=>237,
#           2011=>224,
#           2012=>208,
#           2013=>215,
#           2014=>218}>>,
#     "SOUTH ROUTT RE 3"=>
#      #<District:0x007fe01a061a38
#       @enrollment=
#        #<Enrollment:0x007fe01a061a10
#         @annual_enrollment=
#          {2009=>435,
#           2010=>409,
#           2011=>390,
#           2012=>419,
#           2013=>407,
#           2014=>391}>>,
#     "SPRINGFIELD RE-4"=>
#      #<District:0x007fe01a061970
#       @enrollment=
#        #<Enrollment:0x007fe01a061948
#         @annual_enrollment=
#          {2009=>300,
#           2010=>292,
#           2011=>300,
#           2012=>312,
#           2013=>299,
#           2014=>299}>>,
#     "ST VRAIN VALLEY RE 1J"=>
#      #<District:0x007fe01a0617b8
#       @enrollment=
#        #<Enrollment:0x007fe01a061740
#         @annual_enrollment=
#          {2009=>26724,
#           2010=>27379,
#           2011=>28109,
#           2012=>29382,
#           2013=>30195,
#           2014=>31076}>>,
#     "STEAMBOAT SPRINGS RE-2"=>
#      #<District:0x007fe01a0616a0
#       @enrollment=
#        #<Enrollment:0x007fe01a061650
#         @annual_enrollment=
#          {2009=>2152,
#           2010=>2233,
#           2011=>2282,
#           2012=>2320,
#           2013=>2401,
#           2014=>2468}>>,
#     "STRASBURG 31J"=>
#      #<District:0x007fe01a061510
#       @enrollment=
#        #<Enrollment:0x007fe01a0614e8
#         @annual_enrollment=
#          {2009=>1041,
#           2010=>1026,
#           2011=>1022,
#           2012=>1001,
#           2013=>1072,
#           2014=>1042}>>,
#     "STRATTON R-4"=>
#      #<District:0x007fe01a061420
#       @enrollment=
#        #<Enrollment:0x007fe01a061308
#         @annual_enrollment=
#          {2009=>209,
#           2010=>215,
#           2011=>174,
#           2012=>186,
#           2013=>186,
#           2014=>212}>>,
#     "SUMMIT RE-1"=>
#      #<District:0x007fe01a061268
#       @enrollment=
#        #<Enrollment:0x007fe01a061240
#         @annual_enrollment=
#          {2009=>3089,
#           2010=>3124,
#           2011=>3151,
#           2012=>3156,
#           2013=>3287,
#           2014=>3345}>>,
#     "SWINK 33"=>
#      #<District:0x007fe01a060fc0
#       @enrollment=
#        #<Enrollment:0x007fe01a060f98
#         @annual_enrollment=
#          {2009=>378,
#           2010=>374,
#           2011=>355,
#           2012=>346,
#           2013=>336,
#           2014=>351}>>,
#     "TELLURIDE R-1"=>
#      #<District:0x007fe01a060ea8
#       @enrollment=
#        #<Enrollment:0x007fe01a060e30
#         @annual_enrollment=
#          {2009=>699,
#           2010=>697,
#           2011=>752,
#           2012=>806,
#           2013=>842,
#           2014=>898}>>,
#     "THOMPSON R-2J"=>
#      #<District:0x007fe01a060ca0
#       @enrollment=
#        #<Enrollment:0x007fe01a060c78
#         @annual_enrollment=
#          {2009=>15225,
#           2010=>15310,
#           2011=>15655,
#           2012=>16042,
#           2013=>16210,
#           2014=>16133}>>,
#     "TRINIDAD 1"=>
#      #<District:0x007fe01a060bb0
#       @enrollment=
#        #<Enrollment:0x007fe01a060a98
#         @annual_enrollment=
#          {2009=>1401,
#           2010=>1352,
#           2011=>1365,
#           2012=>1198,
#           2013=>1019,
#           2014=>1025}>>,
#     "VALLEY RE-1"=>
#      #<District:0x007fe01a0609d0
#       @enrollment=
#        #<Enrollment:0x007fe01a060980
#         @annual_enrollment=
#          {2009=>2502,
#           2010=>2436,
#           2011=>2350,
#           2012=>2315,
#           2013=>2305,
#           2014=>2272}>>,
#     "VILAS RE-5"=>
#      #<District:0x007fe01a0607f0
#       @enrollment=
#        #<Enrollment:0x007fe01a0607c8
#         @annual_enrollment=
#          {2009=>415,
#           2010=>354,
#           2011=>289,
#           2012=>216,
#           2013=>127,
#           2014=>104}>>,
#     "WALSH RE-1"=>
#      #<District:0x007fe01a060700
#       @enrollment=
#        #<Enrollment:0x007fe01a0606d8
#         @annual_enrollment=
#          {2009=>167,
#           2010=>178,
#           2011=>161,
#           2012=>158,
#           2013=>156,
#           2014=>156}>>,
#     "WELD COUNTY RE-1"=>
#      #<District:0x007fe01a060570
#       @enrollment=
#        #<Enrollment:0x007fe01a060520
#         @annual_enrollment=
#          {2009=>1784,
#           2010=>1986,
#           2011=>1895,
#           2012=>1933,
#           2013=>1922,
#           2014=>1990}>>,
#     "WELD COUNTY S/D RE-8"=>
#      #<District:0x007fe01a060408
#       @enrollment=
#        #<Enrollment:0x007fe01a0603e0
#         @annual_enrollment=
#          {2009=>2423,
#           2010=>2403,
#           2011=>2470,
#           2012=>2411,
#           2013=>2415,
#           2014=>2333}>>,
#     "WELDON VALLEY RE-20(J)"=>
#      #<District:0x007fe01a060160
#       @enrollment=
#        #<Enrollment:0x007fe01a060138
#         @annual_enrollment=
#          {2009=>211,
#           2010=>222,
#           2011=>212,
#           2012=>210,
#           2013=>221,
#           2014=>244}>>,
#     "WEST END RE-2"=>
#      #<District:0x007fe01b01bed8
#       @enrollment=
#        #<Enrollment:0x007fe01b01be88
#         @annual_enrollment=
#          {2009=>346,
#           2010=>347,
#           2011=>338,
#           2012=>293,
#           2013=>258,
#           2014=>274}>>,
#     "WEST GRAND 1-JT"=>
#      #<District:0x007fe01b01baf0
#       @enrollment=
#        #<Enrollment:0x007fe01b01ba78
#         @annual_enrollment=
#          {2009=>451,
#           2010=>429,
#           2011=>423,
#           2012=>434,
#           2013=>440,
#           2014=>422}>>,
#     "WEST YUMA COUNTY RJ-1"=>
#      #<District:0x007fe01b01b4d8
#       @enrollment=
#        #<Enrollment:0x007fe01b01b4b0
#         @annual_enrollment=
#          {2009=>0, 2010=>0, 2011=>0, 2012=>0, 2013=>0, 2014=>0}>>,
#     "WESTMINSTER 50"=>
#      #<District:0x007fe01b01b348
#       @enrollment=
#        #<Enrollment:0x007fe01b01b2d0
#         @annual_enrollment=
#          {2009=>9862,
#           2010=>10049,
#           2011=>10124,
#           2012=>10069,
#           2013=>10101,
#           2014=>10161}>>,
#     "WIDEFIELD 3"=>
#      #<District:0x007fe01b01ad58
#       @enrollment=
#        #<Enrollment:0x007fe01b01ac68
#         @annual_enrollment=
#          {2009=>8851,
#           2010=>8963,
#           2011=>9184,
#           2012=>9297,
#           2013=>9364,
#           2014=>9283}>>,
#     "WIGGINS RE-50(J)"=>
#      #<District:0x007fe01b01a9c0
#       @enrollment=
#        #<Enrollment:0x007fe01b01a998
#         @annual_enrollment=
#          {2009=>566,
#           2010=>547,
#           2011=>537,
#           2012=>550,
#           2013=>563,
#           2014=>575}>>,
#     "WILEY RE-13 JT"=>
#      #<District:0x007fe01b01a588
#       @enrollment=
#        #<Enrollment:0x007fe01b01a560
#         @annual_enrollment=
#          {2009=>236,
#           2010=>237,
#           2011=>235,
#           2012=>242,
#           2013=>226,
#           2014=>250}>>,
#     "WINDSOR RE-4"=>
#      #<District:0x007fe01b01a358
#       @enrollment=
#        #<Enrollment:0x007fe01b01a330
#         @annual_enrollment=
#          {2009=>4082,
#           2010=>4364,
#           2011=>4582,
#           2012=>4739,
#           2013=>4821,
#           2014=>5102}>>,
#     "WOODLAND PARK RE-2"=>
#      #<District:0x007fe01b019cf0
#       @enrollment=
#        #<Enrollment:0x007fe01b019ca0
#         @annual_enrollment=
#          {2009=>2797,
#           2010=>2752,
#           2011=>2753,
#           2012=>2617,
#           2013=>2586,
#           2014=>2495}>>,
#     "WOODLIN R-104"=>
#      #<District:0x007fe01b0196d8
#       @enrollment=
#        #<Enrollment:0x007fe01b019638
#         @annual_enrollment=
#          {2009=>105, 2010=>113, 2011=>105, 2012=>93, 2013=>90, 2014=>102}>>,
#     "WRAY SCHOOL DISTRICT RD-2"=>
#      #<District:0x007fe01b019548
#       @enrollment=
#        #<Enrollment:0x007fe01b019480
#         @annual_enrollment=
#          {2009=>702,
#           2010=>714,
#           2011=>728,
#           2012=>741,
#           2013=>724,
#           2014=>693}>>,
#     "YUMA SCHOOL DISTRICT 1"=>
#      #<District:0x007fe01b018dc8
#       @enrollment=
#        #<Enrollment:0x007fe01b018cd8
#         @annual_enrollment=
#          {2009=>823,
#           2010=>849,
#           2011=>829,
#           2012=>816,
#           2013=>813,
#           2014=>824}>>}
# = dr.find_by_name("COLORADO")
