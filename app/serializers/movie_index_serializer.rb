class MovieIndexSerializer < ActiveModel::Serializer
  attributes  :id,
              :guidebox_id,
              :thumbnail
end
