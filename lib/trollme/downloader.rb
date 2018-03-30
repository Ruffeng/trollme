require 'pry'
require 'open-uri'
module Trollme
  module Downloader
    module_function

    SetFolder = Class.new(RuntimeError)
    OpenFile = Class.new(RuntimeError)
    SaveFile = Class.new(RuntimeError)


    def call(topic)
      set_defaults(topic)
      set_folder
      if File.exist?(@file)
        get_existing_file(@file)
      else
        download_image_and_return_path
      end
    rescue SetFolder
      abort "Something went wrong to set your folder's download directory"
    rescue OpenFile
      abort 'Was not possible to open the image from internet'
    rescue SaveFile
      abort 'Was not possible to create a file'
    end

    class << self
      private

      def set_defaults(topic)
        @file = topic['file']
        @url = topic['url']
      end

      def set_folder
        Dir.chdir(File.expand_path('~/Downloads'))
      rescue Errno::ENOENT
        raise SetFolder
      end

      def get_existing_file(path)
        "#{Dir.pwd}/#{path}"
      end

      def download_image_and_return_path
        new_file = File.open(file, 'wb') { |new_file| write_image(new_file) }
        get_existing_file(new_file.path)
      rescue Errno::ENOENT
        rollback
        raise SaveFile
      end

      def write_image(file)
        file << open(url).read
      rescue Errno::ENOENT
        rollback
        raise OpenFile
      rescue SocketError
        rollback
        raise OpenFile
      end

      def rollback
        File.delete(file)
      end

      attr_reader :file, :url
    end
  end
end
