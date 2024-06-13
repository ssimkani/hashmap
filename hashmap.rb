# frozen_string_literal: true

class HashMap
  attr_reader :hash_map, :length, :load_factor, :threshold

  def initialize(size)
    @hash_map = Array.new(size)
    @length = @hash_map.compact.length
    @load_factor = 0.8
    @threshold = @length * @load_factor
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
  end

  def get(key)
    index = hash(key) % length
    hash_map[index][1]
  rescue StandardError
    nil
  end

  def has?(key)
    index = hash(key) % length
    !hash_map[index].nil?
  end

  def remove(key)
    index = hash(key) % length
    hash_map[index] = nil
    hash_map[index]
  rescue StandardError
    nil
  end

  def clear
    @hash_map = Array.new(hash_map.length)
  end
end
