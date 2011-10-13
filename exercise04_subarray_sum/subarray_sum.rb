class Array # Monkey patched array, seemed the right thing to do for this.
  def biggest_subarray
    # Decided to just raise an error here if there are only negative numbers and/or zeros
    raise RuntimeError, 'Array has no positive numbers' if self.all? { |x| 0 >= x }

    largest_found = 0 # Arguably don't need this, but it saves me running a sum op everytime I compare
    largest_array = []

    (1..self.length).each do |cons|
      self.each_cons(cons) do |subarray|
        # No need to check for existence of positive numbers here anymore, as we're guaranteed at least one.
        sum = subarray.inject(:+)   # Only sum once, and use the sum more than once.
        next if sum < largest_found # Prefer this to a postfix, as the rest of my logic doesn't have to be indented

        largest_found = sum
        largest_array = subarray
      end
    end

    [largest_found, largest_array]
  end
end
