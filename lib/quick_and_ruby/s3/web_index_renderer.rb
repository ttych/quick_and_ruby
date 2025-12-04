# frozen_string_literal: true

require 'erb'

module QuickAndRuby
  module S3
    class WebIndexRenderer
      DEFAULT_TEMPLATE = <<~HTML
        <!DOCTYPE html>
        <html>
        <head>
            <title><%= path %></title>
            <style>
                body { font-family: Arial, sans-serif; margin: 20px; }
                h1 { color: #333; }
                table { border-collapse: collapse; width: 100%; margin-top: 20px; }
                th, td { padding: 8px 12px; text-align: left; border-bottom: 1px solid #ddd; }
                th { background-color: #f4f4f4; font-weight: bold; }
                tr:hover { background-color: #f9f9f9; }
                a { color: #0066cc; text-decoration: none; }
                a:hover { text-decoration: underline; }
                .size { font-family: monospace; }
                .date { color: #666; }
                .dir { font-weight: bold; color: #228822; }
            </style>
        </head>
        <body>
            <h1><%= path %></h1>

            <% unless path == '/' %>
            <p><a class="dir" href="../index.html">../</a></p>
            <% end %>

            <% if files.empty? %>
            <p>No files found.</p>
            <% else %>
            <table>
                <tr>
                    <th>Filename</th>
                    <th>Last Modified</th>
                    <th>Size</th>
                </tr>
                <% files.each do |file| %>
                <tr>
                    <% if file[:is_directory] %>
                    <td class="dir"><a href="<%= file[:filename_relative_path] %>index.html"><%= file[:filename] %></a></td>
                    <td class="date"></td>
                    <td class="size"></td>
                    <% else %>
                    <td><a href="<%= file[:filename_relative_path] %>"><%= file[:filename] %></a></td>
                    <td class="date"><%= format_date(file[:last_modified]) %></td>
                    <td class="size"><%= format_size(file[:size]) %></td>
                    <% end %>
                </tr>
                <% end %>
            </table>
            <p><%= files.size %> item(s)</p>
            <% end %>
        </body>
        </html>
      HTML

      attr_reader :template

      def initialize(template = DEFAULT_TEMPLATE)
        @template = ERB.new(template)
      end

      def generate(path:, files:)
        template.result(binding)
      end

      def format_date(date)
        date.strftime('%Y-%m-%d %H:%M')
      end

      def format_size(bytes)
        return '0 B' if bytes.zero?

        units = %w[B KB MB GB TB]
        size = bytes.to_f
        unit = 0

        while size >= 1024 && unit < units.size - 1
          size /= 1024
          unit += 1
        end

        format("%.2f #{units[unit]}", size)
      end
    end
  end
end
