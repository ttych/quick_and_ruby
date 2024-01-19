# frozen_string_literal: true

module QuickAndRuby
  module String
    module Case
      def snakecase
        gsub(/\s+/, '_').gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
      end

      # def snakecase2
      #   return downcase if match(/\A[A-Z]+\z/)
      #   gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      #     gsub(/([a-z])([A-Z])/, '\1_\2').
      #     downcase
      # end
    end
  end
end
