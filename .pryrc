# .pryrc


#Pry.config.command_prefix = ';'

Pry.config.prompt = [
  proc { |target_self, nest_level, pry|
    prompt = "[#{pry.input_array.size}] "
    prompt << "#{Rails.version}@" if defined?(Rails)
    prompt << "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}(#{Pry.view_clip(target_self)})"
    prompt << ":#{nest_level}" unless nest_level.zero?
    prompt << '> '
    prompt
  },

  proc { |target_self, nest_level, pry|
    prompt = "[#{pry.input_array.size}] "
    prompt << "#{Rails.version}@" if defined?(Rails)
    prompt << "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}(#{Pry.view_clip(target_self)})"
    prompt << ":#{nest_level}" unless nest_level.zero?
    prompt << '| '
    prompt
  }
]

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue Exception => e
  puts "Unable to load 'awesome_print', please install 'awesome_print'."
end


# vim: set ft=ruby:
# __END__
