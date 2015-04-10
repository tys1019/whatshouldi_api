class ShowSerializer < ActiveModel::Serializer
  attributes  :title, :overview, :poster_path, :runtime, :guidebox_id, :artwork, :rottentomatoes_id, :imdb_id, :themoviedb_id, :cast, :purchase_web_sources, :free_web_sources, :subscription_web_sources
end
