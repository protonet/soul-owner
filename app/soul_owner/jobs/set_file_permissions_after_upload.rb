class SoulOwner::SetFilePermissionsAfterUpload < SoulOwner::BaseJob
  def perform(path, uid, mtime)
    logger.info "job=SetFilePermissionsAfterUpload path=#{path} uid=#{uid} mtime=#{mtime}"
    SoulOwner.file_utils.tap do |fs|
      fs.chown uid.to_i, SoulOwner.gid, path
      fs.chmod SoulOwner::FILE_PERMISSIONS, path
      fs.touch path, mtime: mtime.to_i if mtime
    end
  end
end