class InvoicePic < ApplicationRecord
  mount_uploader :url, ImageUploader
  serialize :url, JSON # If you use SQLite, add this line.
end
