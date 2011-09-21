class BookUtils
    def self.valid_isbn13?(isbn)
        isbn_nums = isbn.to_s.gsub('-', '').split('').map { |n| n.to_i }
        check     = 0

        isbn_nums.each_with_index do |num, index|
            check += (index.next.odd?) ? num : num * 3
        end

        check % 10 == 0
    end
end
