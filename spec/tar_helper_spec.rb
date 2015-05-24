require 'spec_helper'
require_relative '../lib/capistrano/tasks/tar_helper'

describe TarHelper do
  context 'Given a TarHelper' do
    let(:mock_cap) { double('cap') }
    let(:tar) { described_class.new(mock_cap, opts) }
    let(:opts) { {} }

    context 'with a local file path' do
      before do
        opts[:local_path] = '/path/to/local/tar'
      end

      context 'when this file already exists' do
        before do
          allow(mock_cap).to receive(:test).with("[ -f #{opts[:local_path]} ]")
            .and_return(true)
        end

        it 'knows that the file exists' do
          expect(tar.local_file_exists?).to be(true)
        end

        it 'will not attempt to create it' do
          expect(mock_cap).not_to receive(:execute)
          tar.build_local_tar_file
        end
      end
    end
  end
end