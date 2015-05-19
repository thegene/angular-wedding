namespace :tar do
  task :check do
    on release_roles(:all) do
      test(:ls, File.join(releases_path, fetch(:current_revision)))
    end
  end

  task :set_current_revision do
    set_release_path(fetch(:current_revision))
  end

  task :create_release do
    run_locally do
      release_tar.build_local_tar_file_from(fetch(:tar_source_path))
    end

    on roles(:all) do
      release_tar.upload_and_expand_as!(release_path)
    end

    run_locally do
      release_tar.delete_tmp!
    end
  end

  after :deploy, 'pictures:link'

  def release_tar
   TarHelper.new(self, ['wedding', fetch(:current_revision)].join('.'), target: releases_path)
  end

  task :ensure_revision do
    run_locally {
      set(:current_revision, capture(:git, 'rev-parse', '--short', 'HEAD').strip)
    } unless fetch(:current_revision)
  end

  # https://github.com/capistrano/capistrano/issues/722
  # bypasses cap's default loading 
  desc 'Sets up to use tar as scm'
  task :setup do
    set :scm, :tar
    invoke 'tar:ensure_revision'
    invoke 'tar:set_current_revision'
  end

end

namespace :deploy do

  before :starting, 'tar:setup'
  Rake::Task['new_release_path'].clear

end