# A class with only class methods should be a module.
# IMHO in this case you could also have monkey-patched
# biggest_subarray into Array.
class Array
  def biggest_subarray(array)
    raise SubArrayAllNegError, 'Array has no positive numbers' if array.all? { |x| 0 > x }

    largest_found = 0 # Arguably don't need this, but it saves me running a sum op everytime I compare
    largest_array = []

    (1..array.length).each do |cons|
      array.each_cons(cons) do |subarray|
        sum = subarray.inject(:+)
        next if sum < largest_found # Prefer this to a postfix, as the rest of my logic doesn't have to be indented

        largest_found = sum
        largest_array = subarray
      end
    end

    [largest_found, largest_array]
  end
end
