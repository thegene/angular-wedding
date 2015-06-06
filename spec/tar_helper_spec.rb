require 'spec_helper'
require_relative '../lib/capistrano/tasks/tar_helper'

describe TarHelper do
  context 'Given a TarHelper' do
    let(:mock_cap) { double('cap') }
    let(:local_path) { '/path/to/local/tar_file_foo' }
    let(:target_upload_dir) { '/var/www/apps/somewhere/shared'}
    let(:tar) { described_class.new(mock_cap, local_tar_file: local_path, 
      target_upload_dir: target_upload_dir) }

    context 'with a local file path and source' do
      let(:source) { '/something/to/tar' }

      context 'when this file already exists' do
        before do
          allow(mock_cap).to receive(:test).with("[ -f #{local_path} ]")
            .and_return(true)
        end

        it 'will not attempt to create it' do
          expect(mock_cap).not_to receive(:execute)
          tar.build_local_tar_file_from(source)
        end
      end
      context 'which does not already exist' do
        before do
          allow(mock_cap).to receive(:test).with("[ -f #{local_path} ]")
            .and_return(false)
        end

        it 'will attempt to create it' do
          expect(mock_cap).to receive(:execute)
            .with("tar jcvf #{local_path} --directory=#{source} .")
          tar.build_local_tar_file_from(source)
        end
      end

      describe 'Uploading and expanding files' do
        let(:expand_as) { 'expand_dir' }

        it 'uses cap to upload' do
          expect(mock_cap).to receive(:upload!).with(local_path,
            target_upload_dir)
          tar.upload!
        end

        it 'creates the target directory' do
          expect(mock_cap).to receive(:execute).with(
            "mkdir #{target_upload_dir}/#{expand_as}")
          expect(mock_cap).to receive(:execute).with(
            "tar xvf #{target_upload_dir}/tar_file_foo " \
            "--directory=#{target_upload_dir}/#{expand_as}")
          expect(mock_cap).to receive(:test)
            .with("[ -d #{target_upload_dir}/#{expand_as} ]")
            .and_return(false)
          expect(mock_cap).to receive(:test)
            .with("[ -f #{target_upload_dir}/tar_file_foo ]")
            .and_return(false)
          tar.expand_as!(expand_as)
        end
      end

    end
  end
end