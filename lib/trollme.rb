require 'trollme/version'
require 'trollme/downloader'

module Trollme
  module_function

  def run
    Downloader::call
  end
end
