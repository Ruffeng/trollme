module Trollme
  module ChangeBackground
    module_function

    def call(path)
      result = system("osascript -e 'tell application \"System Events\" to set picture of every desktop to (\"#{path}\" as POSIX file as alias)' ")
      raise 'an error ocurred when changing the background' unless result
    end
  end
end
