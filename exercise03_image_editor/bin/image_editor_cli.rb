#!/usr/bin/env ruby

require '../lib/image_editor'

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


