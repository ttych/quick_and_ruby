require 'logger'
require 'ostruct'
require 'webrick'
require 'webrick/httpproxy'

module QuickAndRuby
  module Proxy
    # service
    # proxy instance
    class Proxy
      def initialize(options, proxy_service = WEBrick::HTTPProxyServer)
        @options = options
        @proxy_service = proxy_service
      end

      def start
        configure_trap
        proxy.start
      end

      private

      attr_reader :options, :proxy_service

      def logger
        unless @logger
          @logger = Logger.new($stderr)
          @logger.level = Logger::DEBUG
        end
        @logger
      end

      def proxy
        @proxy ||= proxy_service.new(**proxy_options)
      end

      def proxy_options
        base_proxy_options.merge(remote_proxy_options)
                          .merge(logger_options)
      end

      def base_proxy_options
        { BindAddress: options[:bind],
          Port: options[:port] }
      end

      def remote_proxy_options
        if options[:proxy_host]
          uri = OpenStruct.new(
            userinfo: options[:user],
            host: options[:proxy_host],
            port: options[:proxy_port]
          )
          return { ProxyURI: uri }
        end
        {}
      end

      def logger_options
        { Logger: logger }
      end

      def configure_trap
        trap('INT') { proxy.shutdown }
        trap('TERM') { proxy.shutdown }
      end
    end
  end
end
