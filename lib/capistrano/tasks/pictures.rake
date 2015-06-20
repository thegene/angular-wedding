require 'fileutils'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source"
  task :upload do
    invoke 'pictures:build_local_tar_file'
    invoke 'pictures:upload_pictures_tar'
    invoke 'pictures:delete_tmp'
  end

  desc 'Builds local tar file from provided source'
  task :build_local_tar_file do
    run_locally do
      picture_bundle_tar.build_local_tar_file_from(ENV['source'])
    end
  end

  desc 'Uploads and expands a pictures tar file, specify upload to specify file'
  task :upload_pictures_tar do
    on roles(:app) do
      picture_bundle_tar.tap do |tar|
        tar.upload!
        tar.expand_as!("pictures")
      end
    end
  end

  task :delete_tmp do
    run_locally do
      picture_bundle_tar.delete_tmp!
    end
  end

  desc "Links to the pictures dir"
  task :link do
    on roles(:app) do
      unless test("[ -L #{current_path}/pictures ]")
        execute("ln -s #{shared_path}/pictures #{current_path}/pictures")
      end
    end
  end

  def picture_bundle_tar
    local_tar_file = ENV['tar_file'] ? ENV['tar_file'] : '/tmp/pictures_upload.tar'
    TarHelper.new(self,
      target_upload_dir: shared_path,
      local_tar_file: local_tar_file)
  end

end

