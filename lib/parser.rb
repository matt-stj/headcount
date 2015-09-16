class Loader

# gives the DR data that it wants
def initialize(directory)
  #files.each do |file|
    #load file, open it.
    #call a method to parse the data into onbjects
    # return those things
  end

  #Returns a Hash
  def pupil_enrollment_loader
    file = '/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data/Pupil enrollment.csv'
    @pupil_data = CSV.read(file, headers: true, header_converters: :symbol).map {|row| row.to_h}
  end

end
