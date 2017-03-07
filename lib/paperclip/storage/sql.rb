require "active_support/core_ext/hash/keys"

module Paperclip
  module Storage
    module Sql
      def self.extended(base)
        base.instance_eval do
          @sql_options = @options[:sql_options] || {}
        end
      end

      def flush_writes
        @queued_for_write.each do |style, file|
          u = @sql_options[:table].new
          u.filename = path(style)
          u.bits = file.read
          u.ctype = file.content_type
          u.save
        end
        after_flush_writes
        @queued_for_write.clear
      end

      def flush_deletes
        @queued_for_delete.each do |p|
          u = @sql_options[:table].find_by(filename: p)
          u.destroy if u != nil
        end
        @queued_for_delete.clear
      end

      def copy_to_local_file(style = default_style, destination_path)
      end

      def exists?(style = default_style)
        u = @sql_options[:table].find_by(filename: path(style))
        return u != nil
      end

      class FileExists < RuntimeError
      end
    end
  end
end
