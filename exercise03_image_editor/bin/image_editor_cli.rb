#!/usr/bin/env ruby

require_relative '../lib/image_editor'

class String
  def prompt(options = {})
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

class IO
  def self.gets_with_options(options = {})
    user_input = gets
    user_input.chomp! unless options.has_key? :no_chomp
    user_input.strip! if     options.has_key? :strip # Strip should override options like chomp                                                               
    
    user_input # A return appears to be necessary here.
  end
end

allowed_commands = %w{I C L V H F S X ?}
command          = "Welcome to a simple image editing simulator.\nType ? for help, or a command to get started: ".prompt same_line: true
image            = ImageEditor.new

loop do
    commands = command.upcase.split
    main_cmd = commands[0]
    break if main_cmd == 'X'

    if allowed_commands.index(main_cmd)
        case main_cmd
        when 'I'
            image = ImageEditor.new(commands[1], commands[2])
        when 'C'
            image.clear
        when 'L'


        end

    else
        puts "I don't have a '#{main_cmd}' command. Type ? for help."
    end

    command = "Enter a command: ".prompt same_line: true
end

puts "Goodbye"
