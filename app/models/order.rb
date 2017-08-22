class Order < ApplicationRecord
  belongs_to :patch
  has_many :orderlists
end
