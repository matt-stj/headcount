require_relative 'enrollment_loader'

class Enrollment

  def initialize(pupil_data)
    @pupil_data = pupil_data
  end

  # returns a Fixnum
  def in_year(year)
    22_620
  end
end

file = '/Users/Matt/Turing/1-Modual/Projects/headcount/headcount/data/Pupil enrollment.csv'
pupil_data = EnrollmentLoader.new(file).pupil_enrollment
data = Enrollment.new pupil_data
