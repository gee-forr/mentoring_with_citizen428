class SubArraySum
  def self.biggest_subarray(array)
    largest_found = 0
    largest_array = []

    (1..array.length).each do |cons|
      array.each_cons do |subarray|
        next if subarray.sort[-1] <= 0 # No positive numbers in this array.

        #largest_found = 
      end
    end
  end
end
