require 'fileutils'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source"
  task upload: :defaults do
    invoke :build_local_tar_file
    invoke :upload_pictures
    invoke :delete_tmp
  end

  desc 'Builds local tar file from provided source'
  task build_local_tar_file: :defaults do
    run_locally do
      picture_bundle_tar.build_local_tar_file_from(fetch(:source, ENV['source']))
    end
  end

  desc 'Uploads and expands a pictures tar file, specify upload_tar to specify file'
  task upload_pictures_tar: :defaults do
    on roles(:app) do
      picture_bundle_tar.upload_and_expand_as!("#{shared_path}/photos")
    end
  end

  task delete_tmp: :defaults do
    run_locally do
      picture_bundle_tar.delete_tmp!
    end
  end

  task :defaults do
    [:source, :upload_tar].each do |var|
      set(var, ENV[var.to_s]) if ENV[var.to_s]
    end
  end

  desc "Links to the photos dir"
  task :link do
    on roles(:app) do
      execute("ln -s #{shared_path}/photos #{current_path}/photos")
    end
  end

  def picture_bundle_tar
    TarHelper.new(self, 'picture_bundle',
      local_tmp_file: fetch(:upload_tar, nil))
  end

end

