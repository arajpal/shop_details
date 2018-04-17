# frozen_string_literal: true

require 'yaml'
# store all the data contained by shop
module DataSource
  def all_users
    YAML.load_file 'users_data.yaml'
  end

  def all_products
    YAML.load_file 'products_data.yaml'
  end

  def details(fetch)
    case fetch
    when 'users'
      trader(_trade = all_users)
    when 'products'
      trader(_trade = all_products)
    end
  end

  def trader(trade)
    trade.each do |trade_data|
      trade_data.each do |key, value|
        puts "#{key} : #{value}"
      end
      puts ''
    end
  end
end
