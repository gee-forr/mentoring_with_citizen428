class Array
  def biggest_subarray
    raise RuntimeError, 'Array has no positive numbers' if self.all? { |x| 0 > x }

    largest_found = 0 # Arguably don't need this, but it saves me running a sum op everytime I compare
    largest_array = []

    (1..self.length).each do |cons|
      self.each_cons(cons) do |subarray|
        sum = subarray.inject(:+)
        next if sum < largest_found # Prefer this to a postfix, as the rest of my logic doesn't have to be indented

        largest_found = sum
        largest_array = subarray
      end
    end

    [largest_found, largest_array]
  end
end
