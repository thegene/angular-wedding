require 'fileutils'
require 'pry'

set :dev_picture_dir, File.expand_path('app/pictures/dev')

namespace :pictures do
  desc "Copies pictures directory, specify source and target"
  task :upload do
    invoke 'pictures:build_bundle'
    invoke 'pictures:copy_to_destination'
    invoke 'pictures:clean_up_tmp'
  end

  task :build_bundle do
    run_locally do
      source = ENV['source'] || fetch(:dev_picture_dir) # @todo remove dev_picture_dir
      tar_file_name = set(:tar_file_name, 'picture_bundle.tar.bz2')
      picture_bundle = set(:picture_bundle,
        "#{File.expand_path('/tmp')}/#{tar_file_name}")

      ensure_gone!(picture_bundle)
      build_tar(source, picture_bundle)
    end
  end

  task :copy_to_destination do
    tar = destination_path(fetch(:tar_file_name))

    on roles(:app) do
      ensure_gone!(tar)
      upload!(fetch(:picture_bundle), deploy_to)
      expand_tar!(tar, 'pictures')
      ensure_gone!(tar)
    end
  end

  task :clean_up_tmp do
    run_locally do
      ensure_gone!(fetch(:picture_bundle))
    end
  end

  def ensure_gone!(file_path)
    execute("rm -rf #{file_path}") if test("ls #{file_path}")
  end

  def build_tar(source, target)
    execute "tar jcvf #{target} --directory=#{source} ."
  end

  def expand_tar!(tar, target_name)
    target = destination_path(target_name)
    ensure_empty_dir(target)
    execute "tar xvf #{tar} -C #{target}"
  end

  def destination_path(path)
    "#{deploy_to}/#{path}"
  end

  def ensure_empty_dir(dir)
    if test("ls #{dir}")
      execute("rm -rf #{dir}/*")
    else
      execute("mkdir #{dir}")
    end
  end

end

