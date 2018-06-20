require 'yaml'

module Trollme
  module Topic
    module_function

    def call(topic)
      defaults(topic)
      return random_topic unless topic_is_in_list_and_present(topic)
      picture_from_topic(topic)
    end

    class << self
      private

      def defaults(topic)
        @yaml = YAML.load_file(topics_path)
        @topic = downcase_topic(topic)
      end

      def downcase_topic(topic)
        topic.downcase! if topic
      end

      def topics_path
        File.expand_path(File.join(__dir__, '..', 'external', 'topics.yml'))
      end

      def topic_is_in_list_and_present(topic)
        topic && yaml.key?(topic)
      end

      def random_topic
        picture_from_topic(yaml.keys.sample)
      end

      def picture_from_topic(topic)
        yaml[topic].sample
      end

      attr_reader :yaml, :topic
    end
  end
end
