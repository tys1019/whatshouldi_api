class SavedShow < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :show
end
