class SubArraySum
  def self.biggest_subarray(array)
    largest_found = 0 # Arguably don't need this, but it saves me running a sum op everytime I compare
    largest_array = []

    (1..array.length).each do |cons|
      array.each_cons(cons) do |subarray|
        next if subarray.sort[-1] <= 0              # No positive numbers in this array.
        next if subarray.inject(:+) < largest_found # This is not as big as previous sums

        largest_found = subarray.inject(:+)
        largest_array = subarray
      end
    end

    return nil if largest_array.empty?

    [largest_found, largest_array]
  end
end
