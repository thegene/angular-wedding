require 'fileutils'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source"
  task upload: :set_vars do
    invoke 'pictures:build_local_tar_file'
    invoke 'pictures:upload_pictures_tar'
    invoke 'pictures:delete_tmp'
  end

  desc 'Builds local tar file from provided source'
  task build_local_tar_file: :set_vars do
    run_locally do
      picture_bundle_tar.build_local_tar_file_from(fetch(:source, ENV['source']))
    end
  end

  desc 'Uploads and expands a pictures tar file, specify upload to specify file'
  task upload_pictures_tar: :set_vars do
    on roles(:app) do
      picture_bundle_tar.upload_and_expand_as!("#{shared_path}/photos")
    end
  end

  task delete_tmp: :set_vars do
    run_locally do
      picture_bundle_tar.delete_tmp!
    end
  end

  task :set_vars do
    [:source, :upload].each do |var|
      set(var, ENV[var.to_s]) if ENV[var.to_s]
    end
  end

  desc "Links to the photos dir"
  task :link do
    on roles(:app) do
      unless test("[ -L #{shared_path}/photos ]")
        execute("ln -s #{shared_path}/photos #{current_path}/photos")
      end
    end
  end

  def picture_bundle_tar
    TarHelper.new(self,
      source: fetch(:source),
      local_tmp_file: fetch(:upload, nil))
  end

end

