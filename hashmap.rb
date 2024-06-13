# frozen_string_literal: true

class HashMap
  attr_reader :map, :length, :load_factor, :threshold

  def initialize(size)
    @map = Array.new(size)
    @length = @map.compact.length
    @load_factor = 0.8
    @threshold = @length * @load_factor
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end