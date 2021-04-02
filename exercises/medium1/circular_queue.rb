# A circular queue is a collection of objects stored in a buffer that is treated as though it is connected end-to-end in a circle. When an object is added to this circular queue, it is added to the position that immediately follows the most recently added object, while removing an object always removes the object that has been in the queue the longest.

# This works as long as there are empty spots in the buffer. If the buffer becomes full, adding a new object to the queue requires getting rid of an existing object; with a circular queue, the object that has been in the queue the longest is discarded and replaced by the new object.

# Assuming we have a circular queue with room for 3 objects, the circular queue looks and acts like this: (see problem)

# Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to CircularQueue::new, and should provide the following methods:
# - enqueue to add an object to the queue
# - dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty

# You may assume that none of the values stored in the queue are nil (however, nil may be used to designate empty spots in the buffer).

class CircularQueue
  attr_accessor :queue
  attr_reader :size
  
  def initialize(max_size)
    @queue = Array.new(max_size)
    @size = max_size
  end
  
  def dequeue
    queue.unshift(nil)
    queue.pop
  end
  
  def enqueue(object)
    if queue.any?(&:nil?)
      (-1).downto(-size) do |i|
        if queue[i].nil?
          queue[i] = object
          break
        end
      end
    else
      @queue.pop
      @queue.unshift(object)
    end
    return
  end
end

# Examples:
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1
# puts queue
queue.enqueue(3)
# puts queue
queue.enqueue(4)
# puts queue
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil