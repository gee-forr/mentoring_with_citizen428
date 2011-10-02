require 'pry'

class ImageEditor
    WHITE = 'O'

    attr_reader :grid

    def initialize(width = 2, height = 2)
        @found_neighbours = [] # Used for filling
        @width  = width
        @height = height
        @grid   = Array.new(@height) do
            Array.new(@width, WHITE)
        end
    end

    def to_s
        @grid.inject('') do |output, row|
            output += row.join('') + "\n"
        end
    end

    def clear
        initialize(@width, @height)
    end

    def colour_pixel(row, col, colour)
        @grid[row - 1][col - 1] = colour
    end

    def horizontal_segment(row, start, stop, colour)
        adj_start = start - 1
        adj_stop  = stop  - 1
        @grid[row-1].fill(colour, adj_start..adj_stop)
    end

    def vertical_segment(col, start, stop, colour)
        (start..stop).each do |row|
            colour_pixel(row, col, colour)
        end
    end

    def fill(row, col, colour)
        @neighbours = find_neighbours(row, col)

        walk_grid(row, col, colour)


    end



    private
    
    def walk_grid(row, col, colour)
        begin
            @neighbours.each do |x, y|
                next if neighbours_found?(x, y)
                n_row = x + 1
                n_col = y + 1
                binding.pry

                @neighbours << find_neighbours(n_row, n_col)
            end
        end until found_all_neighbours?
    end

    def find_neighbours(row, col)
        x          = row - 1
        y          = col - 1
        rows       = @grid.size
        cols       = @grid[0].size
        colour     = pixel(x, y)
        neighbours = []
        
        # top neighbour
        unless row == 1 # If we're not already on the top row
            neighbours << [x - 1, y] if pixel(x - 1, y) == colour
        end

        # bottom neighbour
        unless row == rows # If we're not already at the bottom row
            neighbours << [x + 1, y] if pixel(x + 1, y) == colour
        end

        # left neighbour
        unless col == 1 # If we're not already on the left-most column
            neighbours << [x, y - 1] if pixel(x, y - 1) == colour
        end

        # right neighbour
        unless col == cols # If we're not already on the right most column
            neighbours << [x, y + 1] if pixel(x, y + 1) == colour
        end

        neighbours_found(x, y) # Mark that we've found neighbours for this pixel
        neighbours
    end

    def pixel(x, y) # Note, 0-indexed lookup
        @grid[x][y]
    end

    def neighbours_found(x, y)
        @found_neighbours << [x, y]
    end

    def neighbours_found?(x, y)
        @found_neighbours.index([x, y]) ? true : false
    end

    def found_all_neighbours?
        @neighbours_found.sort == @neighbours.sort
        binding.pry
    end
end










