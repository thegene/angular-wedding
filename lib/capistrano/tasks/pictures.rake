require 'fileutils'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source and target"
  task :upload do
    invoke 'pictures:build_bundle'


    invoke 'pictures:clean_up_tmp'
  end

  task :build_bundle do
    run_locally do
      source = ENV['source'] || fetch(:dev_picture_dir) # @todo remove dev_picture_dir
      picture_bundle = set(:picture_bundle,
        "#{File.expand_path('/tmp')}/picture_bundle.tar.bz2")

      ensure_gone(picture_bundle)
      build_tar(source, picture_bundle)
    end
  end

  task :copy_to_destination do

  end

  task :clean_up_tmp do
    ensure_gone(fetch(:picture_bundle))
  end

  def ensure_gone(file_path)
    FileUtils.rm(file_path) if File.exist?(file_path)
  end

  def build_tar(source, target)
    execute "tar jcvf #{target} #{source}"
  end

end

