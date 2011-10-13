# A class with only class methods should be a module.
# IMHO in this case you could also have monkey-patched
# biggest_subarray into Array.
class SubArraySum
  def self.biggest_subarray(array)
    largest_found = 0 # Arguably don't need this, but it saves me running a sum op everytime I compare
    largest_array = []

    (1..array.length).each do |cons|
      array.each_cons(cons) do |subarray|
        # if you do something more intuitive, you won't need a comment
        # :-)
        # e.g. subarray.any? { |x| x >= 0 }
        next if subarray.sort[-1] <= 0              # No positive numbers in this array.
        next if subarray.inject(:+) < largest_found # This is not as big as previous sums

        largest_found = subarray.inject(:+)
        # you are summing the array twice, which is a bit wasteful
        # i propose
        # sum = subarray.inject(:+)
        # if sum < largest found
        #   next
        # else
        #   largest_found = sum
        #   largest_array = subarray
        # end
        largest_array = subarray
      end
    end

    # should we really return nil here? doesn't this only happend if
    # the method gets wrong input? would an exception make more sense?
    return nil if largest_array.empty?

    [largest_found, largest_array]
  end
end
