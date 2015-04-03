class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :imdb_id, :themoviedb_id, :guidebox_id, :rottentomatoes_id, :tagline, :overview, :poster_path, :artwork, :runtime, :genres, :tmdb_vote_average, :rt_ratings, :rt_reviews, :trailer, :purchase_web_sources, :subscription_web_sources, :other_sources
end
