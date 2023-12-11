class CurrencyRate < ApplicationRecord
  validates :currency, presence: true
  validates :rate, presence: true, numericality: { greater_than: 0, less_than: 10000 }
  validates :date, presence: true
  validate :rate_has_two_decimal_places, if: -> { rate.present? }

  def rate_has_two_decimal_places
    errors.add(:rate, 'has more than two decimal places') if rate.round(2) != rate
  end

  validates :currency, uniqueness: { scope: :date }
end
