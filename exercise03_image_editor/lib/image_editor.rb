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
        @grid[row-1].fill(colour, (adj_start..adj_stop))
    end

    def vertical_segment(col, start, stop, colour)
        (start..stop).each do |row|
            colour_pixel(row, col, colour)
        end
    end

    def fill(row, col, colour)
        x          = col - 1
        y          = row - 1
        old_colour = pixel(x, y)

        flood_fill(x, y, old_colour, colour)
    end

    # Private method pixels are referenced by 0-indexed coords
    private

    def flood_fill(x, y, old_colour, new_colour)
        return if pixel(x, y) != old_colour

        colour_pixel(y.next, x.next, new_colour) # colour pixel uses row, col, not x, y

        row        = y.next
        bottom     = @grid.size
        col        = x.next
        right_most = @grid[0].size

        # Fill pixel above
        flood_fill(x, y - 1, old_colour, new_colour) unless row == 1
        
        # Fill pixel below
        flood_fill(x, y + 1, old_colour, new_colour) unless row == bottom
        
        # Fill pixel to the left
        flood_fill(x - 1, y, old_colour, new_colour) unless col == 1

        # Fill pixel to the right
        flood_fill(x + 1, y, old_colour, new_colour) unless col == right_most
    end

    def pixel(x, y) # Note, 0-indexed lookup
        @grid[y][x]
    end
end
