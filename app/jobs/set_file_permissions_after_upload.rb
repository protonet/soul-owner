class SoulOwner::SetFilePermissionsAfterUpload < SoulOwner::BaseJob
  PERMISSIONS = 0660

  def perform(path, uid, mtime)
    SoulOwner.file_utils.tap do |fs|
      fs.chown uid.to_i, SoulOwner.gid, path
      fs.chmod PERMISSIONS, path
      fs.touch path, mtime: mtime.to_i if mtime
    end
  end
end