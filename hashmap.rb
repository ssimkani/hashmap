# frozen_string_literal: true

require_relative 'linked_list'

require 'pry-byebug'

# Class for the Hashmap data structure
class HashMap
  attr_reader :hash_map, :length, :size

  def initialize(size)
    @size = size
    @hash_map = Array.new(size) { LinkedList.new }
    @load_factor = 0.8
    @length = 0
  end

  def threshold
    size * @load_factor
  end

  def get_index(key)
    hash(key) % @size
  end

  def increase_size
    old_hash_map = @hash_map.compact
    @size *= 2
    @hash_map = Array.new(@size) { LinkedList.new }
    @length = 0
    old_hash_map.each do |list|
      list.each { |entry| set(entry.value[0], entry.value[1]) }
    end
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = get_index(key)
    list = hash_map[index]
    same_key = false
    list.each do |entry|
      next unless entry.value[0] == key

      entry.value[1] = value
      same_key = true
      break
    end
    list.append([key, value]) unless same_key
    @length += 1
    increase_size if @length > threshold
  end

  def get(key)
    index = get_index(key)
    list = hash_map[index]
    list.each { |entry| return entry[1] if entry[0] == key }
    nil
  rescue StandardError
    nil
  end

  def has?(key)
    index = get_index(key)
    list = hash_map[index]
    list.each { |entry| return true if entry.value[0] == key }
    false
  end

  def remove(key)
    index = get_index(key)
    list = hash_map[index]
    index_to_remove = 0

    list.each do |entry|
      if entry.value[0] == key
        list.remove_at(index_to_remove)
        return entry
      else
        index_to_remove += 1
      end
    end
    @length -= 1
  rescue StandardError
    nil
  end

  def clear
    @hash_map = Array.new(hash_map.length) { LinkedList.new }
    @length = 0
  end

  def keys
    arr_of_keys = []
    hash_map.compact.each { |list| list.each { |entry| arr_of_keys << entry.value[0] } }
    arr_of_keys
  end

  def values
    arr_of_values = []
    hash_map.compact.each { |list| list.each { |entry| arr_of_values << entry.value[1] } }
    arr_of_values
  end

  def entries
    hash_map.select { |list| list.size.positive? }
  end
end

hash_table = HashMap.new(10)

hash_table.set('John', 18)
hash_table.set('Ryan', 20)
hash_table.set('Joseph', 19)
hash_table.set('Miracle', 21)
hash_table.set('Akshar', 22)
hash_table.set('Aishwarya', 23)
hash_table.set('Abhishek', 24)
hash_table.set('Amit', 25)
hash_table.set('Akshay', 26)

puts hash_table.hash_map
puts hash_table.size
