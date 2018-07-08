class Product < ApplicationRecord
  validates :asin, uniqueness: true, allow_blank: false

  has_many :product_scrapes, dependent: :destroy
end
