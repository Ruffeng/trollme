require 'open-uri'
require 'fakefs/spec_helpers'
require 'pry'
require 'spec_helper'

describe Trollme::Downloader do
  include FakeFS::SpecHelpers
  let(:call) { Trollme::Downloader.call }
  let(:picture) { 'picture/jpg' }
  let(:path) { "/Users/testUser/Downloads/#{picture}" }
  let(:buffer) { instance_double(File, path: picture) }
  let(:config) { File.expand_path('~/Downloads', __FILE__) }

  before do
    FakeFS::FileSystem.clone(config)
    allow(File).to receive(:open).and_return(buffer)
  end
  it 'returns a path' do
    expect(call).to be_a_kind_of(String)
  end

  it 'raises error when cannot set the path' do
    allow(Dir).to receive(:chdir).with(config).and_raise(described_class::SetFolder)

    message = "Something went wrong to set your folder's download directory"
    expect { call }.to raise_error(SystemExit, message)
  end

  context 'when the image exists' do
    before { allow_any_instance_of(File).to receive(:exist?).and_return(true) }

    it 'returns the correct path' do
      allow(subject).to receive(:get_existing_file).and_return(path)
      expect(call).to match(/picture/)
      expect(call).to match(/Downloads/)
      expect(call).to match(/Users/)
    end
    it 'does not modify the system' do
      expect(File).not_to receive(:open)
    end
  end

  describe 'when the image does not exists' do
    before { allow(File).to receive(:exist?).and_return(false) }

    context 'when the image is downloaded succesfully' do
      it 'downloads the image' do
        expect(File).to receive(:open)
        call
      end
      it 'puts in the right folder' do
        expect(Dir.pwd).not_to match(/Downloads/)
        call
        expect(Dir.pwd).to match(/Downloads/)
      end
      it 'returns the path with the new image' do
        result = call
        expect(result).to match(/Downloads/)
        expect(result).to match(/picture/)
      end
    end

    context 'when the image fails' do
      after do
        expect(File.exist?(picture)).to eq(false)
      end

      it 'should raise when creates a file fails' do
        allow(File).to receive(:open).and_raise(described_class::SaveFile)

        message = 'Was not possible to create a file'
        expect { call }.to raise_error(SystemExit, message)
      end
      it 'should raise when read a url fails' do
        file_open_mock = RSpec::Mocks::InstanceVerifyingDouble
        allow_any_instance_of(file_open_mock).to receive(:path).and_raise(described_class::OpenFile)
        message = 'Was not possible to open the image from internet'
        expect { call }.to raise_error(SystemExit, message)
      end
    end
  end
end
