require 'spec_helper'
require_relative '../lib/capistrano/tasks/tar_helper'

describe TarHelper do
  context 'Given a TarHelper' do
    let(:mock_cap) { double('cap') }
    let(:tar) { described_class.new(mock_cap, opts) }
    let(:opts) { {} }

    context 'with a local file path and source' do
      let(:source) { '/something/to/tar' }
      let(:local_path) { '/path/to/local/tar' }

      before do
        opts[:local_path] = local_path
        opts[:source] = source
      end

      context 'when this file already exists' do
        before do
          allow(mock_cap).to receive(:test).with("[ -f #{local_path} ]")
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
      context 'when this does not already exists' do
        before do
          allow(mock_cap).to receive(:test).with("[ -f #{local_path} ]")
            .and_return(false)
        end

        it 'will attempt to create it' do
          expect(mock_cap).to receive(:execute)
            .with("tar jcvf #{local_path} --directory=#{source} .")
          tar.build_local_tar_file
        end
      end
    end

  end
end