# frozen_string_literal: true

require_relative 'linked_list'

# Class for the Hashmap data structure
class HashMap
  attr_reader :hash_map, :length, :size

  def initialize(size)
    @size = size
    @hash_map = Array.new(size) { LinkedList.new }
    @load_factor = 0.8
    @length = 0
  end

  # Calculates the threshold at which the hash map should be resized
  def threshold
    size * @load_factor
  end

  # Calculates the index for the given key
  def get_index(key)
    index = hash(key) % @size
    raise IndexError if index.negative? || index >= @size

    index
  end

  # Increases the size of the hash map
  def increase_size
    old_hash_map = @hash_map.compact
    @size *= 2
    @hash_map = Array.new(@size) { LinkedList.new }
    @length = 0
    old_hash_map.each do |list|
      list.each { |entry| set(entry.value[0], entry.value[1]) }
    end
  end

  # Calculates the hash code for the given key
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.to_s.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # Adds a new key-value pair to the hash map
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

  # Returns the value for the given key or nil if the key is not found
  def get(key)
    index = get_index(key)
    list = hash_map[index]
    list.each { |entry| return entry.value[1] if entry.value[0] == key }
    nil
  end

  # Returns true if the key is found in the hash map and false otherwise
  def has?(key)
    index = get_index(key)
    list = hash_map[index]
    list.each { |entry| return true if entry.value[0] == key }
    false
  end

  # Removes the key-value pair with the given key or returns nil if the key is not found
  def remove(key)
    index = get_index(key)
    list = hash_map[index]
    index_to_remove = 0

    list.each do |entry|
      if entry.value[0] == key
        list.remove_at(index_to_remove)
        @length -= 1
        return entry.value
      else
        index_to_remove += 1
      end
    end
    nil
  end

  # Clears the hash map
  def clear
    @hash_map = Array.new(hash_map.length) { LinkedList.new }
    @length = 0
    hash_map
  end

  # Returns the keys in the hash map inside of an array
  def keys
    arr_of_keys = []
    hash_map.compact.each { |list| list.each { |entry| arr_of_keys << entry.value[0] } }
    arr_of_keys
  end

  # Returns all values
  def values
    arr_of_values = []
    hash_map.compact.each { |list| list.each { |entry| arr_of_values << entry.value[1] } }
    arr_of_values
  end

  # Returns the entries or linked lists in the hash map
  def entries
    hash_map.select { |list| list.size.positive? }
  end
end
