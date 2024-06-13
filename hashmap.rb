# frozen_string_literal: true

class HashMap
  attr_reader :hash_map, :length, :threshold

  def initialize(size)
    @hash_map = Array.new(size)
    @length = @hash_map.compact.length
    @load_factor = 0.8
    @threshold = @length * @load_factor
  end

  def increase_size
    @hash_map += Array.new(length)
  end

  def linear_probe?(key, index)
    hash_map[index] && hash_map[index][0] != key
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % length
    hash_map[index] = [key, value]
    increase_size if hash_map.compact.length > threshold
  end

  def get(key)
    index = hash(key) % length
    raise_error(index)
    hash_map[index][1]
  rescue StandardError
    nil
  end

  def has?(key)
    index = hash(key) % length
    raise_error(index)
    !hash_map[index].nil?
  end

  def remove(key)
    index = hash(key) % length
    raise_error(index)
    hash_map[index] = nil
    hash_map[index]
  rescue StandardError
    nil
  end

  def clear
    @hash_map = Array.new(hash_map.length)
  end

  def keys
    hash_map.compact.map(&:first)
  end

  def values
    hash_map.compact.map(&:last)
  end

  def entries
    hash_map.compact
  end

  def raise_error(index)
    raise IndexError if index.negative? || index >= length
  end
end
