require 'trollme/version'
require 'trollme/downloader'
require 'trollme/change_background'

module Trollme
  module_function

  def run
    path = Downloader.call
    ChangeBackground.call(path)
  end
end
