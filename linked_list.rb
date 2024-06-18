# frozen_string_literal: true

require_relative 'node'

# This class represents the linked list data structure
class LinkedList
  attr_accessor :size

  # Initializes a new linked list with the head and size
  def initialize
    @head = nil
    @size = 0
  end

  # Adds a new node with the given value to the front of the list
  def prepend(value)
    @head = Node.new(value, @head)
    @size += 1
  end

  # Adds a new node with the given value to the end of the list
  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      node = @head
      node = node.next_node while node.next_node
      node.next_node = new_node
    end
    @size += 1
  end

  # Returns the node at the given index or nil if index is out of bounds
  def at(index)
    index += size if index.negative?
    return nil if index >= @size || @size.zero?

    current = @head
    index.times { current = current.next_node }
    current.value
  end

  # Removes and returns the last node of the linked list
  def pop
    node = @head
    (size - 2).times { node = node.next_node }
    popped_node = node.next_node
    node.next_node = nil
    @size -= 1
    popped_node.value
  end

  # Returns true if the value is in the list and false otherwise
  def contains?(value)
    current_node = @head
    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end
    false
  end

  # Returns the index of the value that is provided as an argument or nil if the value is not in the list
  def find(value)
    current_node = @head
    index = 0
    (size - 1).times do
      return index if current_node.value == value

      current_node = current_node.next_node
      index += 1
    end
    nil
  end

  def each
    current_node = @head
    while current_node
      yield current_node
      current_node = current_node.next_node
    end
  end

  # Inserts a new node with a given value and index
  def insert_at(value, index)
    index += size + 1 if index.negative?
    return unless index <= @size && index >= 0

    if index.zero?
      prepend(value)
    elsif index == @size
      append(value)
    else
      node = Node.new(value)
      current_node = @head
      (index - 1).times { current_node = current_node.next_node }
      node.next_node = current_node.next_node
      current_node.next_node = node
    end

    @size += 1
  end

  # Removes the node at the given index
  def remove_at(index)
    index += size if index.negative?
    return if index >= @size || @size.zero?

    if index.zero?
      @head = @head.next_node
    else
      current_node = @head
      (index - 1).times { current_node = current_node.next_node }
      current_node.next_node = current_node.next_node.next_node
    end
    @size -= 1
  end

  # Prints the linked list
  def to_s
    result = ''
    current = @head
    until current.nil?
      result += "( #{current.value} ) -> "
      current = current.next_node
    end
    "#{result}nil"
  end

  # Returns the head value
  def head
    @head.value
  end

  # Returns the tail value
  def tail
    current = @head
    current = current.next_node until current.next_node.nil?
    current.value
  end
end
