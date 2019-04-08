require 'uri'

module QuickAndRuby
  module Proxy
    # service
    # parse env for proxy exe
    class EnvParser
      INDEX_TO_KEY = { 3 => :user,
                       4 => :proxy_host,
                       5 => :proxy_port }.freeze

      def initialize(env = ENV)
        @env = env
      end

      def parse
        parsed = _parsed_proxy
        return {} unless parsed

        INDEX_TO_KEY.each_with_object({}) do |(index, key), options|
          options[key] = parsed[index] if parsed[index]
        end
      end

      private

      attr_reader :env

      def _http_proxy
        env['HTTP_PROXY'] || env['http_proxy']
      end

      def _parsed_proxy
        return unless _http_proxy

        _http_proxy.match(URI::DEFAULT_PARSER.make_regexp)
      end
    end
  end
end
