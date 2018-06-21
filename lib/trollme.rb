require 'trollme/version'
require 'trollme/downloader'
require 'trollme/change_background'
require 'trollme/topic'

module Trollme
  module_function

  def run(topic: nil)
    topic = Topic.call(topic)
    path = Downloader.call(topic)
    ChangeBackground.call(path)
  end
end
