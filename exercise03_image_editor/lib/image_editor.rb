class ImageEditor
    WHITE = 'O'

    attr_reader :grid

    def initialize(width = 2, height = 2)
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
end
