# frozen_string_literal: true

require 'yaml'
require 'json'

module QuickAndRuby
  module Data
    class Context
      attr_reader :here, :id, :parent

      def initialize(here, id: nil, parent: nil)
        @here = here
        @id = id
        @parent = parent
      end

      def to_s
        if here.is_a? Array
          indices = []
          here.each_index { |i| indices << i }
          indices.join(' ')
        elsif here.is_a? Hash
          here.keys.join(' ')
        else
          here.to_s
        end
      end

      def pwd
        pwd_parts = []
        pwd_cur = self
        while pwd_cur
          pwd_parts.unshift pwd_cur.id if pwd_cur.id
          pwd_cur = pwd_cur.parent
        end
        "/" + pwd_parts.join('/')
      end

      def cat(path)
        item_at(path)
      end

      def cd(path)
        if path == '..'
          parent
        else
          item = item_at(path)
          if item.nil?
            nil
          else
            Context.new(item, id: path, parent: self)
          end
        end
      end

      def completions(input)
        to_s.split(/\s+/).grep(/^#{input}/)
      end

      private

      def item_at(path)
        if path == '..'
          parent.here
        elsif here.is_a? Array
          here[path.to_i]
        elsif here.is_a? Hash
          here[path]
        end
      end

      def self.from_yaml(yaml_data)
        new(YAML.parse(yaml_data))
      end

      def self.from_json(json_data)
        new(JSON.parse(json_data))
      end
    end
  end
end
