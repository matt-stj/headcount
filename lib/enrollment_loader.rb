require 'csv'  # => true

class EnrollmentLoader
  def initialize(data_dir)
    @data_dir = data_dir
  end

  def pupil_enrollment
    filename = File.join(@data_dir, 'Pupil enrollment.csv')
    @pupil_data = CSV.read(filename, headers: true, header_converters: :symbol).map {|row| row.to_h}
  end

end  # => :pupil_enrollment

dir = '/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data'
loader = EnrollmentLoader.new(dir).pupil_enrollment
# => [{:location=>"Colorado",
#      :timeframe=>"2009",
#      :dataformat=>"Number",
#      :data=>"832368"},
#     {:location=>"Colorado",
#      :timeframe=>"2010",
#      :dataformat=>"Number",
#      :data=>"843316"},
