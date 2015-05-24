class TarHelper
  attr_accessor :cap, :local_source, :local_path, :target_path

  def initialize(cap, opts={})
    @cap = cap
    @local_path = opts[:local_path]
    @target_path = opts[:target_path]
    @source = opts[:source]
  end

  def delete_tmp!
    ensure_gone!(local_path)
  end

  def build_local_tar_file
    unless local_file_exists?
      ensure_gone!(local_path)
      build_tar!(source, local_path)
    end
  end

  def upload_and_expand_as!(upload_as)
    cap.upload!(local_path, target)
    expand_tar!(destination_path, upload_as)
    ensure_gone!(destination_path)
  end

  def local_file_exists?
    cap.test("[ -f #{local_path} ]")
  end

  private

  def ensure_gone!(file_path)
    cap.execute("rm -rf #{file_path}") if cap.test("ls #{file_path}")
  end

  def expand_tar!(tar, as)
    ensure_empty_dir(as)
    cap.execute "tar xvf #{tar} -C #{as}"
  end

  def full_tar_name
    local_path.split('/').last
  end

  def destination_path
    "#{target}/#{full_tar_name}"
  end

  def target
    opts[:target] || cap.shared_path
  end

  def build_tar!(source, target)
    cap.execute "tar jcvf #{target} --directory=#{source} ."
  end

  def ensure_empty_dir(dir)
    if cap.test("ls #{dir}")
      cap.execute("rm -rf #{dir}/*")
    else
      cap.execute("mkdir #{dir}")
    end
  end
end