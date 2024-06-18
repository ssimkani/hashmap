# frozen_string_literal: true

require_relative 'lib/hashmap'

hash_table = HashMap.new(16)

countries_and_capitals = [
  ['USA', 'Washington DC'],
  ['Canada', 'Ottawa'],
  ['Mexico', 'Mexico City'],
  ['Germany', 'Berlin'],
  ['France', 'Paris'],
  ['Italy', 'Rome'],
  ['Spain', 'Madrid'],
  ['Australia', 'Canberra'],
  ['New Zealand', 'Wellington'],
  ['China', 'Beijing'],
  ['Japan', 'Tokyo'],
  ['India', 'New Delhi'],
  ['Russia', 'Moscow']
]

countries_and_capitals.each do |country_and_capital|
  hash_table.set(country_and_capital[0], country_and_capital[1])
end

puts hash_table.entries
