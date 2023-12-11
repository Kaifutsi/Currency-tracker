class HomeController < ApplicationController
  def index
    @currency_rates = CurrencyRate.order('date DESC').limit(10)
  end

    def weekly_price_change
    @weekly_changes = calculate_weekly_changes
  end

  private

  def calculate_weekly_changes
    changes = {}
    CurrencyRate.select(:currency).distinct.pluck(:currency).each do |currency|
      changes[currency] = (1..4).map do |week_ago|
        monday = week_ago.weeks.ago.beginning_of_week
        sunday = week_ago.weeks.ago.end_of_week

        monday_rate = CurrencyRate.where(currency: currency, date: monday).pick(:rate)
        sunday_rate = CurrencyRate.where(currency: currency, date: sunday).pick(:rate)

        percentage_change = if monday_rate && sunday_rate && monday_rate != 0
                              ((sunday_rate - monday_rate) / monday_rate) * 100
                            else
                              nil
                            end

        { monday_rate: monday_rate, sunday_rate: sunday_rate, percentage_change: percentage_change }
      end
    end

    changes
  end
end
