# frozen_string_literal: true

require 'aws-sdk-s3'

require_relative 'web_index_renderer'

# rubocop:disable Metrics/ParameterLists, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/BlockLength
module QuickAndRuby
  module S3
    class WebIndexer
      attr_reader :bucket, :endpoint_url, :access_key, :secret_key, :region, :index_template

      def initialize(bucket:, endpoint_url:, access_key:, secret_key:, region: 'us-east-1',
                     index_template: WebIndexRenderer.new, **extra)
        @bucket = bucket
        @endpoint_url = endpoint_url
        @access_key = access_key
        @secret_key = secret_key
        @region = region
        @index_template = index_template
        @extra = extra
      end

      def index(*paths, nested: false)
        paths.append('/') if paths.empty?

        status = paths.inject(0) { |status, path| status + index_directory(path, nested: nested) }
        status = 1 if status != 0
        status
      end

      def list_directory(path, recursive: false)
        objects = []
        continuation_token = nil
        prefix = path.end_with?('/') ? path : "#{path}/"
        loop do
          resp = s3_client.list_objects_v2(
            bucket: bucket,
            prefix: prefix,
            delimiter: (recursive ? nil : '/'),
            continuation_token: continuation_token
          )

          resp.common_prefixes&.each do |cp|
            next unless cp.prefix.start_with?(prefix)

            relativepath = cp.prefix.delete_prefix(prefix)

            objects.append(
              { filename: relativepath.chomp('/').split('/').last,
                filename_relative_path: relativepath.to_s,
                filename_realpath: "/#{bucket}/#{cp.prefix}",
                last_modified: nil,
                size: nil,
                is_directory: true }
            )
          end

          resp.contents.each do |object|
            next if object.key == File.join(prefix, 'index.html')

            relative_key = object.key.sub(prefix, '')
            next if !recursive && relative_key.inlcude?('/') && !relative_key.empty?

            objects.append(
              { filename: relative_key,
                filename_relative_path: relative_key,
                filename_realpath: "/#{bucket}/#{object.key}",
                last_modified: object.last_modified,
                size: object.size,
                is_directory: false }
            )
          end

          continuation_token = resp.next_continuation_token
          break unless continuation_token
        end

        objects
      end

      def index_directory(path, nested: false)
        files = list_directory(path, recursive: nested)
        index_content = index_template.generate(
          path: path,
          files: files
        )
        s3_client.put_object(bucket: bucket, key: "#{path}/index.html", body: index_content,
                             acl: 'public-read', content_type: 'text/html')
        0
      end

      def s3_client
        @s3_client ||= Aws::S3::Client.new(
          access_key_id: access_key,
          secret_access_key: secret_key,
          endpoint: endpoint_url,
          region: region,
          force_path_style: true,
          ssl_verify_peer: false
        )
      end
    end
  end
end
# rubocop:enable Metrics/ParameterLists, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/BlockLength
