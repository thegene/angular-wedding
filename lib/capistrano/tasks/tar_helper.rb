class TarHelper
  attr_accessor :cap, :tar_name, :opts

  def initialize(cap, tar_name, opts={})
    @cap = cap
    @tar_name = tar_name
    @opts = opts
  end

  def delete_tmp!
    ensure_gone!(local_tmp_file)
  end

  def build_local_tar_file_from(source)
    ensure_gone!(local_tmp_file)
    build_tar!(source, local_tmp_file)
  end

  def upload_and_expand_as!(upload_as)
    cap.upload!(local_tmp_file, target)
    expand_tar!(destination_path, upload_as)
    ensure_gone!(destination_path)
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
    if opts[:local_tmp_file]
      opts[:local_tmp_file].split('/').last
    else
      "#{tar_name}.tar.bz2"
    end
  end

  def local_tmp_dir
    opts[:tmp_dir] || '/tmp'
  end

  def local_tmp_file
    opts[:local_tmp_file] || "#{local_tmp_dir}/#{full_tar_name}"
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