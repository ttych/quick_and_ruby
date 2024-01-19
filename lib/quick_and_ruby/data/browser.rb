# frozen_string_literal: true

require 'reline'

module QuickAndRuby
  module Data
    class Browser
      attr_reader :root_context

      def initialize(root_context)
        @root_context = root_context
      end

      def main
        command = nil
        current_context = root_context

        Reline.completion_proc = lambda { |input|
          current_context.completions(input)
        }

        while command != 'exit'
          command = Reline.readline("#{current_context.pwd}> ", true)
          break if command.nil?

          current_context = execute_command(command.strip, current_context)
        end
      end

      private

      def execute_command(command, context)
        case command
        when /^ls$/
          puts context
        when /^cd (.*$)/
          new_context = context.cd(::Regexp.last_match(1))
          if new_context.nil?
            puts "No such key #{::Regexp.last_match(1)}"
          else
            context = new_context
          end
        when /^cat (.*)$/
          item = context.cat(::Regexp.last_match(1))
          if item.nil?
            puts "No such item #{::Regexp.last_match(1)}"
          else
            puts item.inspect
          end
        when /^pwd$/
          puts context.pwd
        when /^help$/
          puts 'cat <item> - print the contents of <item> in the current context'
          puts 'cd  <item> - change context to the context of <item>'
          puts 'cd  ..     - change up one level'
          puts 'ls         - list available items in the current context'
          puts 'pwd        - print context path'
        end
        context
      end

      def complete_command(input, context)
        require 'byebug'
        byebug
      end
    end
  end
end
