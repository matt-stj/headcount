class StatewideTestingLoader
  def self.path
    File.expand_path '../data', __dir__
  end

  def self.load_third_grade_students
    rows = CSV.readlines(path + '/3rd grade students scoring proficient or above on the CSAP_TCAP.csv', headers: true, header_converters: :symbol).map(&:to_h)
    grouped_rows = rows.group_by { |row|  row.fetch(:location) }

    @third_grade_test_scores_repo = {}
    location_with_years = grouped_rows.map do |key, value|
     @third_grade_test_scores_repo[key] ||= value.map {|row| [row.fetch(:timeframe).to_i, value.map {|row| [row.fetch(:score).downcase.to_sym, row.fetch(:data).to_f]}.to_h]}.to_h
    end
    # binding.pry

    @third_grade_test_scores_repo
    # repo_builder(@third_grade_test_scores_repo, groups, :integer)
  end

  # load_third_grade_students
end
