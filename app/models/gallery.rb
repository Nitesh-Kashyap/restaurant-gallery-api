class Gallery < ApplicationRecord
  belongs_to :restaurant
  has_many_attached :images

  validates :name, :description, presence: true

  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) } if images.attached?
  end
end
