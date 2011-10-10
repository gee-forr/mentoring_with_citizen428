#!/usr/bin/env ruby

require_relative '../lib/image_editor'

class String
  def prompt(options = {})
    # Michael: this also uses "print" if someone passes :same_line => false,
    # which is probably unintended
    send(options.has_key?(:same_line) ? :print : :puts, self)

    user_input = IO::gets_with_options(options)
    return user_input unless options.has_key? :regex # We still have some work to do.

    # If we're here, it's cos we still need to check user input against a regex
    while user_input !~ /#{options[:regex]}/
      puts "Sorry, that input was not accepted, please try again."
      user_input = self.gets_with_options(options)
    end

    user_input # Returning it at this point, as return val might be ambiguous by now
  end

end

# I'd be careful with monkey-patching IO here. Using simple prompt
# function could combine String#prompt and IO.gets_with_options
# since handle_out_of_bounds is already a function, I don't see a
# reason to not have another one
class IO
  def self.gets_with_options(options = {})
    user_input = gets
    user_input.chomp! unless options.has_key? :no_chomp
    user_input.strip! if     options.has_key? :strip # Strip should override options like chomp

    user_input # A return appears to be necessary here.
  end
end

def handle_out_of_bounds(image, row, col)
  if image.pixel_in_bounds?(row, col)
    yield
  else
    puts "I cannot perform that task as the pixel is out of bounds."
  end
end

allowed_commands = %w{I C L V H F S X ?}
command          = "Welcome to a simple image editing simulator.\nType ? for help, or a command to get started: ".prompt same_line: true
image            = ImageEditor.new

loop do
  commands = command.upcase.split
  main_cmd = commands[0]

  break if main_cmd == 'X'

  # if allowed_commands.include?(main_cmd)
  if allowed_commands.index(main_cmd)
    case main_cmd
    when 'I'
      image = ImageEditor.new(commands[1].to_i, commands[2].to_i)
    when 'C'
      image.clear
    when 'L'
      row = commands[1].to_i
      col = commands[2].to_i

      handle_out_of_bounds(image, row, col) do
        image.colour_pixel(row, col, commands[3][0].upcase)
      end
    when 'V'
      row_start = commands[2].to_i
      row_stop  = commands[3].to_i
      col       = commands[1].to_i

      handle_out_of_bounds(image, row_start, col) do
        handle_out_of_bounds(image, row_stop, col) do
          image.vertical_segment(col, row_start, row_stop, commands[4][0].upcase)
        end
      end
    when 'H'
      row       = commands[1].to_i
      col_start = commands[2].to_i
      col_stop  = commands[3].to_i

      handle_out_of_bounds(image, row, col_start) do
        handle_out_of_bounds(image, row, col_stop) do
          image.horizontal_segment(row, col_start, col_stop, commands[4][0].upcase)
        end
      end
    when 'F'
      row = commands[1].to_i
      col = commands[2].to_i

      handle_out_of_bounds(image, row, col) do
        image.fill(row, col, commands[3][0].upcase)
      end
    when 'S'
      puts image
    when '?'
      puts <<EOO
The editor supports 9 commands:

1.   I M N. Create a new M x N image with all pixels coloured white (O).
2.   C. Clears the table, setting all pixels to white (O).
3.   L X Y C. Colours the pixel (X,Y) with colour C.
4.   V X Y1 Y2 C. Draw a vertical segment of colour C in column X between rows Y1 and Y2
(inclusive).
5.   H X1 X2 Y C. Draw a horizontal segment of colour C in row Y between columns X1 and X2
(inclusive).
6.   F  X Y C. Fill the region R with the colour C.  R is defined as: Pixel (X,Y) belongs to R. Any other
pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs
to this region.
7.   S. Show the contents of the current image
8.   X. Terminate the session
9.   ?. Help (this output)
EOO
    end
  else
    puts "I don't have a '#{main_cmd}' command. Type ? for help."
  end

  command = "Enter a command: ".prompt same_line: true
end

puts "Goodbye"
