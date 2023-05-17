# frozen_string_literal: true

require 'optparse'
require 'optparse/time'

module QuickAndRuby
  module Proxy
    # service
    # parse proxy exe argv
    # based on standard OptionParser
    class ArgParser
      def initialize(argv)
        @argv = argv
        @options = { verbose: false,
                     bind: '0.0.0.0',
                     port: 8080 }
      end

      def parse
        options_parser.parse!(argv)
        options
      end

      private

      attr_reader :argv, :options

      def options_parser
        @options_parser ||= OptionParser.new do |opts|
          opts.banner = 'Usage: proxy [options]'

          opts.separator ''
          opts.separator 'Options:'

          opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
            options[:verbose] = v
          end

          opts.on('-u', '--user USER:PASSWORD',
                  'specify USER') do |user|
            options[:user] = user
          end

          opts.on('-H', '--proxy-host HOST',
                  'specify proxy HOST to use') do |host|
            options[:proxy_host] = host
          end

          opts.on('-P', '--proxy-port PORT',
                  'specify proxy PORT to use') do |port|
            options[:proxy_port] = port
          end

          opts.on('-b', '--bind IP',
                  'specify IP to bind on') do |ip|
            options[:bind] = ip
          end

          opts.on('-p', '--port PORT',
                  'specify PORT to listen on') do |port|
            options[:port] = port
          end

          opts.on_tail('-h', '--help', 'Show this message') do
            puts opts
            exit
          end

          opts.on_tail('--version', 'Show version') do
            puts ::QuickAndRuby::VERSION
            exit
          end
        end
      end
    end
  end
end
