require 'fileutils'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source"
  task :upload do
    if ENV['source']
      source = ENV['source']
    else
      raise 'Please specify source'
    end

    run_locally do
      picture_bundle_tar.build_local_tar_file_from(source)
    end

    on roles(:app) do
      picture_bundle_tar.upload_and_expand_as!("#{shared_path}/photos")
    end

    run_locally do
      picture_bundle_tar.delete_tmp!
    end
  end

  desc "Links to the photos dir"
  task :link do
    on roles(:app) do
      execute("ln -s #{shared_path}/photos #{current_path}/photos")
    end
  end

  def picture_bundle_tar
    TarHelper.new(self, 'picture_bundle')
  end

end

