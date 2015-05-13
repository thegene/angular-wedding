require 'fileutils'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source"
  task :upload do
    source = ENV['source'] || fetch(:dev_picture_dir) # @todo remove dev_picture_dir

    run_locally do
      tar.build_local_tar_file_from(source)
    end

    on roles(:app) do
      tar.upload_and_expand_as!("#{deploy_to}/photos")
    end

    run_locally do
      tar.delete_tmp!
    end
  end

  desc "Links to the photos dir"
  task :link do
    on roles(:app) do
      execute("ln -s #{deploy_to}/photos #{current_path}/photos")
    end
  end

  def tar
    fetch(:tar, TarHelper.new(self, 'picture_bundle'))
  end

end

