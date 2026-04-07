class Experience < ApplicationRecord
  belongs_to :user
  validates :company, :position, :start_date, presence: true

  validates_date :start_date,
    on_or_before: ->(record) { record.end_date.presence || Date.current },
    on_or_before_message: "must be on or before end date, or today if ongoing"

  validates_date :end_date,
    after: :start_date,
    after_message: "must be after start date",
    allow_blank: true

  validate :validate_current

  private

  def validate_current
    return if current?

    errors.add(:end_date, "must be present when the experience is not current") if end_date.blank?
  end
end
