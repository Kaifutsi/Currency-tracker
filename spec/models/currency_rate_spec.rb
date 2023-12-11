require 'rails_helper'

RSpec.describe CurrencyRate, type: :model do
  it 'is valid with valid attributes' do
    expect(CurrencyRate.new(currency: 'USD', rate: 75.50, date: Date.today)).to be_valid
  end
  # Тест на отсутствие валюты
  it 'is not valid without a currency' do
    rate = CurrencyRate.new(rate: 75.50, date: Date.today)
    expect(rate).to_not be_valid
  end

  # Тест на отсутствие курса
  it 'is not valid without a rate' do
    rate = CurrencyRate.new(currency: 'USD', date: Date.today)
    expect(rate).to_not be_valid
  end

  # Тест на отсутствие даты
  it 'is not valid without a date' do
    rate = CurrencyRate.new(currency: 'USD', rate: 75.50)
    expect(rate).to_not be_valid
  end

  # Тест на уникальность пары валюта-дата
  it 'has a unique currency and date combination' do
    CurrencyRate.create(currency: 'USD', rate: 75.50, date: Date.today)
    duplicate_rate = CurrencyRate.new(currency: 'USD', rate: 76.00, date: Date.today)
    expect(duplicate_rate).to_not be_valid
  end

  # Тест на корректность формата курса (если требуется)
  it 'has a rate with maximum two decimal places' do
    rate = CurrencyRate.new(currency: 'USD', rate: 75.555, date: Date.today)
    expect(rate).to_not be_valid
  end
end
