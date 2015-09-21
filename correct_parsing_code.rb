
rows = [{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"},
{:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"},
{:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"},
{:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"},
{:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"},
{:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"},
{:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"},
{:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.536"},
{:location=>"Colorado", :score=>"Writing", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.504"},
{:location=>"Colorado", :score=>"Math", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.696"}]

grouped_rows = rows.group_by { |row|  row.fetch(:location) }

hash = {}
location_with_years = grouped_rows.map do |location, rows|
  hash[location] = rows.group_by {|row|
    row.fetch(:timeframe).to_i
  }
  .map {|year, rows|
    [year,
      rows.map {|row|
        [ row.fetch(:score).downcase.to_sym,
          row.fetch(:data)[0..4].to_f
        ]
      }.to_h
    ]
  }.to_h
end

hash

hash

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
[[:a, 1], [:b, 2], [:c, 3]].to_h

# {'ASPEN 1' => {
#    2011 => {math: 0.816, reading: 0.897, writing: 0.826},
#    2012 => {math: 0.818, reading: 0.893, writing: 0.808},
#    2013 => {math: 0.805, reading: 0.901, writing: 0.810},
#    2014 => {math: 0.800, reading: 0.855, writing: 0.789},
#  }
# }
