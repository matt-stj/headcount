require_relative 'enrollment'
require_relative 'district_repository'
require 'csv'

class District
  def enrollment
    Enrollment.new
  end

  def pupil_enrollment_loader
    file = '/Users/rossedfort/code/mod_1/projects/headcount/data/Pupil enrollment.csv'
    data = CSV.read(file, headers: true, header_converters: :symbol).map {|row| row.to_h}
  end

  def list_of_districts
  end
end

enrolled_data = District.new
hash = enrolled_data.pupil_enrollment_loader
# => [{:location=>"Colorado", :timeframe=>"2009", :dataformat=>"Number", :data=>"832368"}, {:location=>"Colorado", :timeframe=>"2010", :dataformat=>"Number", :data=>"843316"}, {:location=>"Colorado", :timeframe=>"2011", :dataformat=>"Number", :data=>"854265"}, {:location=>"Colorado", :timeframe=>"2012", :dataformat=>"Number", :data=>"863561"}, {:location=>"Colorado", :timeframe=>"2013", :dataformat=>"Number", :data=>"876999"}, {:location=>"Colorado", :timeframe=>"2014", :dataformat=>"Number", :data=>"889006"}, {:location=>"ACADEMY 20", :timeframe=>"2009", :dataformat=>"Number", :data=>"22620"}, {:location=>"ACADEMY 20", :timeframe=>"2010", :dataformat=>"Number", :data=>"23119"}, {:location=>"ACADEMY 20", :timeframe=>"2011", :dataformat=>"Number", :data=>"23657"}, {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Number", :data=>"23973"}, {:location=>"ACADEMY 20", :timeframe=>"2013", :dataformat=>"Number", :data=>"24481"}, {:location=>"ACADEMY 20", :timeframe=>"2014", :data...

# hash.map {|row| row[:location].upcase}.uniq
# # => ["COLORADO", "ACADEMY 20", "ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J", "AGATE 300", "AGUILAR REORGANIZED 6", "AKRON R-1", "ALAMOSA RE-11J", "ARCHULETA COUNTY 50 JT", "ARICKAREE R-2", "ARRIBA-FLAGLER C-20", "ASPEN 1", "AULT-HIGHLAND RE-9", "BAYFIELD 10 JT-R", "BENNETT 29J", "BETHUNE R-5", "BIG SANDY 100J", "BOULDER VALLEY RE 2", "BRANSON REORGANIZED 82", "BRIGGSDALE RE-10", "BRIGHTON 27J", "BRUSH RE-2(J)", "BUENA VISTA R-31", "BUFFALO RE-4", "BURLINGTON RE-6J", "BYERS 32J", "CALHAN RJ-1", "CAMPO RE-6", "CANON CITY RE-1", "CENTENNIAL R-1", "CENTER 26 JT", "CHERAW 31", "CHERRY CREEK 5", "CHEYENNE COUNTY RE-5", "CHEYENNE MOUNTAIN 12", "CLEAR CREEK RE-1", "COLORADO SPRINGS 11", "COTOPAXI RE-3", "CREEDE CONSOLIDATED 1", "CRIPPLE CREEK-VICTOR RE-1", "CROWLEY COUNTY RE-1-J", "CUSTER COUNTY SCHOOL DISTRICT C-1", "DE BEQUE 49JT", "DEER TRAIL 26J", "DEL NORTE C-7", "DELTA COUNTY 50(J)", "DENVER COUNTY 1", "DOLORES COUNTY RE NO.2", "DOLORES RE-4A", "DOUGLAS COUNTY RE 1", "DURANGO 9-R", "EADS ...
