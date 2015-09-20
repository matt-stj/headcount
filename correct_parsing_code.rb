
rows = [{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"},  # => {:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}
{:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"},          # => {:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}
{:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"},          # => {:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}
{:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"},       # => {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}
{:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"},       # => {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}
{:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"},       # => {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}
{:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"},       # => {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}
{:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"},       # => {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"}
{:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.504"},       # => {:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.504"}
{:location=>"Colorado", :score=>"Math", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.696"}]          # => [{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"20...

grouped_rows = rows.group_by { |row|  row.fetch(:location) }  # => {"Colorado"=>[{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent", :data=...

hash = {}                                                   # => {}
location_with_years = grouped_rows.map do |location, rows|  # => {"Colorado"=>[{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent", :data=>"...
  hash[location] = rows.group_by {|row|                     # => [{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.504"}, {:lo...
    row.fetch(:timeframe).to_i                              # => 2008, 2009, 2010, 2008, 2009, 2010, 2008, 2009, 2010, 2011
  }                                                         # => {2008=>[{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}], 2009=>[{:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"}], 2010=>[{:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent"...
  .map {|year, rows|
    [year,                                                  # => 2008, 2009, 2010, 2011
      rows.map {|row|                                       # => [{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}], [{:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"}], [{:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.504"}],...
        [ row.fetch(:score).downcase.to_sym,                # => :math, :reading, :writing, :math, :reading, :writing, :math, :reading, :writing, :math
          row.fetch(:data)[0..4].to_f                       # => 0.697, 0.703, 0.501, 0.691, 0.726, 0.536, 0.706, 0.698, 0.504, 0.696
        ]                                                   # => [:math, 0.697], [:reading, 0.703], [:writing, 0.501], [:math, 0.691], [:reading, 0.726], [:writing, 0.536], [:math, 0.706], [:reading, 0.698], [:writing, 0.504], [:math, 0.696]
      }.to_h                                                # => {:math=>0.697, :reading=>0.703, :writing=>0.501}, {:math=>0.691, :reading=>0.726, :writing=>0.536}, {:math=>0.706, :reading=>0.698, :writing=>0.504}, {:math=>0.696}
    ]                                                       # => [2008, {:math=>0.697, :reading=>0.703, :writing=>0.501}], [2009, {:math=>0.691, :reading=>0.726, :writing=>0.536}], [2010, {:math=>0.706, :reading=>0.698, :writing=>0.504}], [2011, {:math=>0.696}]
  }.to_h                                                    # => {2008=>{:math=>0.697, :reading=>0.703, :writing=>0.501}, 2009=>{:math=>0.691, :reading=>0.726, :writing=>0.536}, 2010=>{:math=>0.706, :reading=>0.698, :writing=>0.504}, 2011=>{:math=>0.696}}
end
# => [{2008=>{:math=>0.697, :reading=>0.703, :writing=>0.501},
#      2009=>{:math=>0.691, :reading=>0.726, :writing=>0.536},
#      2010=>{:math=>0.706, :reading=>0.698, :writing=>0.504},
#      2011=>{:math=>0.696}}]

hash  # => {"Colorado"=>{2008=>{:math=>0.697, :reading=>0.703, :writing=>0.501}, 2009=>{:math=>0.691, :reading=>0.726, :writing=>0.536}, 2010=>{:math=>0.706, :reading=>0.698, :writing=>0.504}, 2011=>{:math=>0.696}}}

hash  # => {"Colorado"=>{2008=>{:math=>0.697, :reading=>0.703, :writing=>0.501}, 2009=>{:math=>0.691, :reading=>0.726, :writing=>0.536}, 2010=>{:math=>0.706, :reading=>0.698, :writing=>0.504}, 2011=>{:math=>0.696}}}

# hash_2 = {}
# final = location_with_years.map do |key, value|
#   year =
#  hash_2[key][]


# hash
# ​
# hash.map do |key, value|
#   hash_2[key] = value.map {|row| [key.last, value]}.to_h
# end
# ​
[[:a, 1], [:b, 2], [:c, 3]].to_h  # => {:a=>1, :b=>2, :c=>3}

# {'ASPEN 1' => {
#    2011 => {math: 0.816, reading: 0.897, writing: 0.826},
#    2012 => {math: 0.818, reading: 0.893, writing: 0.808},
#    2013 => {math: 0.805, reading: 0.901, writing: 0.810},
#    2014 => {math: 0.800, reading: 0.855, writing: 0.789},
#  }
# }
