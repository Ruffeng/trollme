require 'pry'
require 'open-uri'
module Trollme
  module Downloader
    module_function

    SetFolder = Class.new(RuntimeError)
    OpenFile = Class.new(RuntimeError)
    SaveFile = Class.new(RuntimeError)

    PICTURE = 'mairena.jpg'.freeze
    URL = 'https://ep00.epimg.net/elpais/imagenes/2017/06/14/fotorrelato/1497431610_448226_1497432498_album_normal.jpg'.freeze

    def call
      set_folder
      if File.exist?(PICTURE)
        get_existing_file(PICTURE)
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

      def set_folder
        Dir.chdir(File.expand_path('~/Downloads'))
      rescue Errno::ENOENT
        raise SetFolder
      end

      def get_existing_file(path)
        "#{Dir.pwd}/#{path}"
      end

      def download_image_and_return_path
        file = File.open(PICTURE, 'wb') { |new_file| write_image(new_file) }
        get_existing_file(file.path)
      rescue Errno::ENOENT
        rollback
        raise SaveFile
      end

      def write_image(file)
        file << open(URL).read
      rescue Errno::ENOENT
        rollback
        raise OpenFile
      rescue SocketError
        rollback
        raise OpenFile
      end

      def rollback
        File.delete(PICTURE)
      end
    end
  end
end
