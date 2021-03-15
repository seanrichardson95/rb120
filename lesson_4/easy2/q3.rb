module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

puts "Orange Lookup Chain:"
puts Orange.ancestors

puts ""
puts "HotSauce Lookup Chain"
puts HotSauce.ancestors