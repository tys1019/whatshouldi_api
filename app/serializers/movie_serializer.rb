class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :imdb_id, :themoviedb_id, :guidebox_id, :rottentomatoes_id, :tagline, :overview, :poster_path, :artwork, :runtime, :genres, :tmdb_vote_average, :rt_ratings, :rt_reviews, :trailer, :free_web_sources, :purchase_web_sources, :subscription_web_sources, :cast
end
