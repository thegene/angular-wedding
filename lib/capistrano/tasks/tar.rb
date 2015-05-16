namespace :tar do
  task :check do
    
  end

  task :store_revision do
    run_locally do
      set(:revision, capture(:git, 'rev-parse', '--short', 'HEAD').strip)
    end
  end
end

namespace :deploy do

  # https://github.com/capistrano/capistrano/issues/722
  # bypasses cap's default loading 
  task :use_tar do
    set :scm, :tar
  end

  before :starting, :use_tar
  after :use_tar, 'tar:store_revision'

end