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
      execute("ln -s #{deploy_to}/photos #{current_path}/photos")
    end
  end

  task :build_bundle do
    run_locally do
      source = ENV['source'] || fetch(:dev_picture_dir) # @todo remove dev_picture_dir
      tar.build_local_tar_file_from(source)
    end
  end

  task :copy_to_destination do
    on roles(:app) do
      tar.upload_and_expand_as!("#{deploy_to}/photos")
    end
  end

  task :clean_up_tmp do
    run_locally do
      # tar.delete_tmp!
    end
  end

  def tar
    fetch(:tar, TarHelper.new(self, 'picture_bundle'))
  end

end

