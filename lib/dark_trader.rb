require 'nokogiri'
require 'open-uri'

def principal_page
  return Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
end

def all_currencies_name(page)
  page = page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol")]')
  a = []
  page.each do |currency_name|
    a << currency_name.text
  end
  return a
end

def all_currencies_price(page)
  page = page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price")]')
  a = []
  page.each do |currency_price|
    a << currency_price.text
  end
  return a
end

def hash_for_currencies(currencies_name, currencies_price)
  a = Hash[currencies_name.zip(currencies_price)]
  b = []
  a.each do |c, d|
    b << {c => d}
  end
  return b
end

def perform
  a = all_currencies_name(principal_page)
  b = all_currencies_price(principal_page)
  hash_for_currencies(a, b)
end
