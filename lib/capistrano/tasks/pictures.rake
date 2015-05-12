require 'fileutils'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source"
  task :upload do
    invoke 'pictures:build_bundle'
    invoke 'pictures:copy_to_destination'
    invoke 'pictures:clean_up_tmp'
  end

  desc "Links to the photos dir"
  task :link do
    on roles(:app) do
      execute("ln -s #{tar.destination_path('photos')} #{current_path}/photos")
    end
  end

  task :build_bundle do
    run_locally do
      source = ENV['source'] || fetch(:dev_picture_dir) # @todo remove dev_picture_dir
      tar_file_name = set(:tar_file_name, 'picture_bundle.tar.bz2')
      picture_bundle = set(:picture_bundle,
        "#{File.expand_path('/tmp')}/#{tar_file_name}")

      tar.ensure_gone!(picture_bundle)
      tar.build_tar(source, picture_bundle)
    end
  end

  task :copy_to_destination do
    tar_file = tar.destination_path(fetch(:tar_file_name))

    on roles(:app) do
      tar.ensure_gone!(tar_file)
      upload!(fetch(:picture_bundle), deploy_to)
      tar.expand_tar!(tar_file, 'photos')
      tar.ensure_gone!(tar_file)
    end
  end

  task :clean_up_tmp do
    run_locally do
      tar.ensure_gone!(fetch(:picture_bundle))
    end
  end

  def tar
    fetch(:tar, TarHelper.new(self))
  end

end

