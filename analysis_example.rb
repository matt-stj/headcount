idk = [
[[2008, 0.697], [2009, 0.619]],
[[2009, 0.619], [2010, 0.706]],
[[2010, 0.706], [2011, 0.696]],
[[2011, 0.696], [2013, 0.722]],
[[2013, 0.722], [2014, 0.715]]
  ]

mapped = idk.map { |(year1, proficiency1), (year2, proficiency2)|
      proficiency2 - proficiency1
    }.reduce(0, :+) / idk.length

mapped # => 0.0036000000000000034

__END__

statewide_testing.proficient_by_grade(3.map) { |year, proficiencies| [year, proficiencies.fetch(subject)]}.sort


.each_cons(2) # for splitting data into groups of years

(c, d), (e, f) = [[11, 12], [21,22]]

c
d
e
f

-------------------------------
def percentageable?(maybe_a_number)
  maybe_a_number.to_f.to_s == maybe_a_number
end
----------------------------------
def top_statewide(subject)
      .fetch
      .select
      .minmax_by
   max.fetch(:proficiency) - min.fetch(:proficiency) / (max.fetch(:year) - min.fetch(:year))
end

.tap {}
