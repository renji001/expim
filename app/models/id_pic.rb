class IdPic < ApplicationRecord
  mount_uploader :url, ImageUploader
  serialize :url, JSON # If you use SQLite, add this line.

  validates :url, uniqueness: true
end
