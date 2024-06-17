# frozen_string_literal: true

# This class represents the nodes for the linked list
class Node
  attr_accessor :value, :next_node

  # Initializes a new node with the value and the next node in the linked list
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
