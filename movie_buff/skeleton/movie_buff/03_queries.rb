def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.joins(:actors).where('actors.name' => those_actors).group(:id).having('COUNT(*)>1').select(:title,:id)

  # SELECT * FROM "movies" INNER JOIN "castings" ON "castings"."movie_id" = "movies"."id" INNER JOIN "actors" ON "actors"."id" = "castings"."actor_id" WHERE "actors"."name" IN ('Ben Affleck', 'Matt Damon')

end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.group('yr/10').order('AVG(score) DESC').limit(1).pluck('(yr/10)*10').first
end

# SELECT (yr/10)*10 AS decade, AVG(score) FROM movies GROUP BY (yr/10) ORDER BY AVG(score) DESC LIMIT 1

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  movielist = Movie.joins(:actors).where('actors.name = ?', name).pluck(:id)
  Actor.joins(:movies).where('movies.id IN (?) AND name != ?', movielist, name).pluck(:name).uniq
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.joins('LEFT OUTER JOIN castings ON actors.id = castings.actor_id').where('castings.movie_id IS NULL').length
end

# SELECT * FROM "actors" LEFT OUTER JOIN castings ON actors.id = castings.actor_id WHERE (castings.movie_id IS NULL)

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

end
