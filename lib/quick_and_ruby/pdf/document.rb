# frozen_string_literal: true

require 'uri'
require 'pdf-reader'

module QuickAndRuby
  module Pdf
    class Document
      DEFAULT_SCHEMES = %w[http https].freeze

      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def extract_links(schemes: DEFAULT_SCHEMES)
        links = []

        doc_reader.pages.each do |page|
          text = page.text
          links += URI.extract(text, schemes)

          annots = page.attributes[:Annots] || []
          annots.each do |annot_ref|
            annot = doc_reader.objects.deref(annot_ref)
            next unless annot.is_a?(Hash) && annot[:A] && annot[:A][:URI]

            target_uri = annot[:A][:URI]

            links += URI.extract(target_uri, schemes)
          end
        end
        links.uniq
      end

      def doc_reader
        @doc_reader ||= PDF::Reader.new(filepath)
      end
    end
  end
end
