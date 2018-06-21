require 'spec_helper'
require 'pry'

describe Trollme::Topic do
  # Not worth it to place it in a shared example
  def expect_file_and_url_to_match(object)
    expect(object['file']).to eq('unicorn1')
    expect(object['url']).to eq('someurl.com')
  end

  def call(topic = 'unicorns')
    subject.call(topic)
  end

  let(:path) { File.expand_path(File.join(__dir__, '..', 'support', 'topics.yml')) }

  before do
    allow(subject).to receive(:topics_path).and_return(path)
  end

  it 'returns a hash with file and url' do
    expect(call).to be_a_kind_of(Hash)
    expect(call.keys.count).to eq(2)
    expect(call.keys).to include('file', 'url')
  end

  context 'when the topic you send is present and exists' do
    it 'returns a topic-related result' do
      expect_file_and_url_to_match(call)
    end
    it 'returns a topic-related when topic is not downcase' do
      expect_file_and_url_to_match(call('UnIcOrNs'))
    end
  end

  context 'when the topic you send is not present or doesn\'t exist' do
    it 'returns a random topic if nothing was passed' do
      expect_file_and_url_to_match(call(nil))
    end
    it 'returns a random topic if wrong topic was passed' do
      expect_file_and_url_to_match(call('Barbie'))
    end
  end
end
