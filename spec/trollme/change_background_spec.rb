require 'spec_helper'

describe Trollme::ChangeBackground do
  let(:path) { '/some/path/picture.jpg' }
  let(:call) { subject.call(path) }

  context 'when system action returns success' do
    before do
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
    end

    it 'does not raise any error' do
      expect { call }.not_to raise_error
    end
  end
  context 'when system action returns fails' do
    before do
      allow_any_instance_of(Kernel).to receive(:system).and_return(false)
    end

    it 'does raise an error' do
      expect { call }.to raise_error(RuntimeError)
    end
  end
end
