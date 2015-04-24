class BookSerializer < ActiveModel::Serializer
  attributes  :google_id,
              :title,
              :thumbnail
end
