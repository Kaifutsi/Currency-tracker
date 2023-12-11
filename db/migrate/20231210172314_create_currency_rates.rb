class CreateCurrencyRates < ActiveRecord::Migration[7.1]
  def change
    create_table :currency_rates do |t|
      t.string :currency
      t.decimal :rate
      t.date :date

      t.timestamps
    end
  end
end
