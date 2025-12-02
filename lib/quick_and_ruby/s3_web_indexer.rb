# frozen_string_literal: true

module QuickAndRuby
  class S3WebIndexer
    attr_reader :options

    def initialize(options: {})
      @options = options
    end

    def index
      0
    end
  end
end
