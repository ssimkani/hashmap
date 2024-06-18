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

  # Iterates through the list and yields each node
  def each
    current_node = @head
    while current_node
      yield current_node
      current_node = current_node.next_node
    end
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
end
