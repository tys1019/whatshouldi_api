class SavedMovie < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :movie
end
