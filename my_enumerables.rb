module Enumerable
  # use block inside my_each_with_index
  def my_each_with_index
    return to_enum(__method__) unless block_given? # Return an enumerator if no block is given

    # self.each_with_index { |el, idx| yield el, idx }
    size.times { |i| yield self[i], i }

    self # Return the array itself
  end

  # only loop inside select
  def my_select
    return to_enum(__method__) unless block_given? # Return an enumerator if no block is given

    result = []

    i = 0
    while i < size do
      result << self[i] if yield self[i]
      i += 1
    end

    result # Return select result
  end

  # use self.my_select to implement my_all?
  def my_all?
    return to_enum(__method__) unless block_given? # Return an enumerator if no block is given

    self.my_select { |el| yield el }.eql?(self)
  end

  # use my_select without self.my_select to implement my_none?
  def my_none?
    return to_enum(__method__) unless block_given? # Return an enumerator if no block is given

    my_select { |el| yield el }.empty?
  end

  # use my_none to implement my_any?
  def my_any?
    return to_enum(__method__) unless block_given? # Return an enumerator if no block is given

    !my_none? { |el| yield el }
  end

  # use my_select to implement my_count?
  def my_count
    return size unless block_given? # Return size of array if no block is given

    my_select { |el| yield el }.size
  end

  # use my_each to implement my_map?
  def my_map
    return to_enum(__method__) unless block_given? # Return an enumerator if no block is given

    result = []
    my_each { |el| result << yield(el) } # It tooks me so long to understand that I need to wrap el with parenthesis

    result # Return select result
  end

  # use my_each to implement my_inject?
  def my_inject(initial)
    accumulator = initial

    my_each { |el| accumulator = yield(accumulator, el) }

    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # just wrap each with my_each
  def my_each
    return to_enum(__method__) unless block_given? # Return an enumerator if no block is given

    self.each { |el| yield el }

    self # Return the array itself
  end
end
