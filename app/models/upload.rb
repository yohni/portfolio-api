class Upload < ApplicationRecord
  has_one_attached :file

  validates :file, presence: true
  validate :file_validation


  private

  def file_validation
    return unless file.attached?

    if file.blob.byte_size > 5.megabytes
      errors.add(:file, "is too large")
    end

    unless file.blob.content_type.in?(%w[image/jpeg image/png image/webp])
      errors.add(:file, "must be an image")
    end
  end
end
