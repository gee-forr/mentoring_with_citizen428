class BookUtils
    def self.valid_isbn13?(isbn)
        isbn  = isbn.to_s.gsub('-', '')
        check = 0

        (0..13).step(2) do |i|
            check += isbn.slice(i, 1).to_i
        end

        (1..12).step(2) do |i|
            check += 3 * isbn.slice(i, 1).to_i
        end

        check % 10 == 0
    end
end
