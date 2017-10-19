def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score).where(yr: (1980..1989), score: (3..5))
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movie.group(:yr).having('MAX(score) < 8').pluck(:yr)

  # Movie.select(:yr).where('score > 8').group(:yr)   #list of years with score at least 8
  # we don't want movies that are in the table above
  # years, where score is not > 8

  # Movie.select(:yr).distinct.where('yr NOT IN' => Movie.select(:yr).where('score > 8'))

  # sql1 = <<-SQL
  # SELECT DISTINCT yr
  # FROM movies
  # WHERE yr NOT IN (
  #   SELECT yr
  #   FROM movies
  #   WHERE score > 8
  #   )
  # SQL
  #
  # ActiveRecord::Base.connection.execute(sql1).map {|el| el['yr']}
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor.joins(:movies).where('movies.title = ?', title).order('castings.ord ASC')
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.joins(:actors).where('castings.ord = 1 AND movies.director_id = castings.actor_id').select(:id, :title, 'actors.name').as_json
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.


  Actor.joins(:castings).where('castings.ord != 1').group(:id).order('COUNT(*) DESC').select(:id, :name, 'COUNT(*) AS roles').limit(2).as_json
  # 
  # SELECT actors.id, actors.name, COUNT(*) AS supporting_roles
  # FROM actors
  # JOIN castings
  #   ON castings.actor_id = actors.id
  # WHERE castings.ord != 1
  # GROUP BY actors.id
  # ORDER BY COUNT(actors.id) DESC

  # from castings
  # joins :actors
  # where ord != 1
  #



  # actors and their count of non-starring roles
          # where ord != 1   - that will get rid of all starring roles
  #
end
