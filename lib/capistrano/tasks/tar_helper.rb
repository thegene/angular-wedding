class TarHelper
  attr_accessor :cap, :local_tar_file, :target_upload_dir

  def initialize(cap, local_tar_file:, target_upload_dir:)
    @cap = cap
    @local_tar_file = local_tar_file
    @target_upload_dir = target_upload_dir
  end

  def delete_local_tar!
    ensure_gone!(local_tar_file)
  end

  def build_local_tar_file_from(source)
    unless local_file_exists?
      build_tar_from!(source)
    end
  end

  def upload!
    cap.upload!(local_tar_file, target_upload_dir)
  end

  def expand_as!(target_name)
    File.join(target_upload_dir, target_name).tap do |target|
      cap.execute("mkdir #{target}") unless cap.test("[ -d #{target} ]")
      cap.execute "tar xvf #{uploaded_file_name} --directory=#{target}"
    end
    ensure_gone!(uploaded_file_name)
  end

  private

  def local_file_exists?
    cap.test("[ -f #{local_tar_file} ]")
  end

  def ensure_gone!(file_path)
    cap.execute("rm -f #{file_path}") if cap.test("[ -f #{file_path} ]")
  end

  def tar_file_name
    local_tar_file.split('/').last
  end

  def uploaded_file_name
    File.join(target_upload_dir, tar_file_name)
  end

  def build_tar_from!(source)
    cap.execute "tar jcvf #{local_tar_file} --directory=#{source} ."
  end
end