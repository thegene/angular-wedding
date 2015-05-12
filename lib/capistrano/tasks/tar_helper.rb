class TarHelper
  attr_accessor :cap

  def initialize(cap)
    @cap = cap
  end

  def ensure_gone!(file_path)
    cap.execute("rm -rf #{file_path}") if cap.test("ls #{file_path}")
  end

  def build_tar(source, target)
    cap.execute "tar jcvf #{target} --directory=#{source} ."
  end

  def expand_tar!(tar, target_name)
    target = destination_path(target_name)
    ensure_empty_dir(target)
    cap.execute "tar xvf #{tar} -C #{target}"
  end

  def destination_path(path)
    "#{cap.deploy_to}/#{path}"
  end

  def ensure_empty_dir(dir)
    if cap.test("ls #{dir}")
      cap.execute("rm -rf #{dir}/*")
    else
      cap.execute("mkdir #{dir}")
    end
  end
end