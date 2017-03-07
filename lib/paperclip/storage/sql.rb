require "active_support/core_ext/hash/keys"


module Paperclip
  module Storage
    module Sql
      def self.extended(base)
        base.instance_eval do
          @sql_options = @options[:sql_options] || {}
          #@options[:path] = nil if @options[:path] == self.class.default_options[:path]
          #dropbox_client # Force creation of dropbox_client
        end
      end

      def flush_writes
        log("flush_writes!")
        @queued_for_write.each do |style, file|
          log("flush_write: #{style} #{file}")
          u = @sql_options[:table].new
          u.filename = path(style)
          u.bits = file.read
          u.ctype = file.content_type
          u.save
          #dropbox_client.put_file(path(style), file.read)
        end
        after_flush_writes
        @queued_for_write.clear
      end

      def flush_deletes
        log("flush_deletes!")
        @queued_for_delete.each do |p|
          u = @sql_options[:table].find_by(filename: p)
          u.destroy if u != nil
          #dropbox_client.file_delete(path)
        end
        @queued_for_delete.clear
      end

      #def url(style_or_options = default_style, options = {})
        #options.merge!(style_or_options) if style_or_options.is_a?(Hash)
        #style = style_or_options.is_a?(Hash) ? default_style : style_or_options
        #url_generator.generate(style, options)
      #end

      #def path(style = default_style)
        #path = @path_generator.generate(style)
        #path = File.join("Public", path) if public_dropbox?
        #path
      #end

      def copy_to_local_file(style = default_style, destination_path)
        #File.open(destination_path, "wb") do |file|
          #file.write(dropbox_client.get_file(path(style)))
        #end
      end

      def exists?(style = default_style)
        log("exists? #{ style }")
        u = @sql_options[:table].find_by(filename: path(style))
        return u != nil
        #return false if not present?
        #metadata = dropbox_client.metadata(path(style))
        #not metadata.nil? and not metadata["is_deleted"]
      #rescue DropboxError
        #false
      end

      #def url_generator
        #@url_generator = GeneratorFactory.build_url_generator(self, @options)
      #end

      class FileExists < RuntimeError
      end
    end
  end
end
