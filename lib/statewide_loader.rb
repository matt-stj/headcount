class StatewideTestingLoader
  def self.path
    File.expand_path '../data', __dir__
  end

  def self.load_third_grade_students
    rows = CSV.readlines(path + '/3rd grade students scoring proficient or above on the CSAP_TCAP.csv', headers: true, header_converters: :symbol).map(&:to_h)
    groups = group_by(rows)
    @third_grade_test_scores_repo = {}
    binding.pry
    repo_builder(@third_grade_test_scores_repo, groups, :integer)
  end

  def self.group_by

  end
end
