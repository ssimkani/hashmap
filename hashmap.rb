# frozen_string_literal: true

# Class for the Hashmap data structure
class HashMap
  attr_reader :hash_map, :length, :threshold

  def initialize(size)
    @size = size
    @hash_map = Array.new(size)
    @length = @hash_map.compact.length
    @load_factor = 0.8
    @threshold = @length * @load_factor
  end

  def increase_size
    @hash_map += Array.new(@size)
    @size *= 2
  end

  def collision?(key, index)
    hash_map[index] && hash_map[index][0] != key
  end

  def find_nil_bucket(key, value)
    index = 0
    hash_map.each do |entry|
      if entry.nil?
        hash_map[index] = [key, value]
        break
      else
        index += 1
      end
    end
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @size
    if collision?(key, index)
      find_nil_bucket(key, value)
    else
      hash_map[index] = [key, value]
    end
    increase_size if hash_map.compact.length > threshold
  end

  def get(key)
    index = hash(key) % @size
    return hash_map.find { |entry| entry[0] == key }[1] if collision?(key, index)

    raise_error(index)
    hash_map[index][1]
  rescue StandardError
    nil
  end

  def has?(key)
    index = hash(key) % @size
    return !!hash_map.find(proc { false }) { |entry| entry[0] == key } if collision?(key, index)

    raise_error(index)
    !hash_map[index].nil?
  end

  def remove(key)
    index = hash(key) % @size
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

hash_table = HashMap.new(10)

hash_table.set('hello', 'world')
hash_table.set('hello', 'world2')

p hash_table.entries
