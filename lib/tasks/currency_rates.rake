require 'httparty'

namespace :currency_rates do
  desc "Fetch currency rates from Central Bank"
  task fetch: :environment do
    response = HTTParty.get("URL_API_ЦЕНТРОБАНКА")

    # Проверяем успешность запроса
    if response.success?
      # Допустим, ответ имеет формат:
      # { "rates": { "USD": 74.23, "EUR": 85.65, ... }, "date": "YYYY-MM-DD" }
      data = response.parsed_response
      rates = data["rates"]
      date = data["date"]

      rates.each do |currency, rate|
        # Создаем или обновляем запись в базе данных
        CurrencyRate.find_or_create_by(currency: currency, date: date) do |cr|
          cr.rate = rate
        end
      end
    else
      puts "Ошибка запроса: #{response.code}"
    end
  end
end
