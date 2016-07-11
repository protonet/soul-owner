class SoulOwner::SetRecursiveFilePermissions < SoulOwner::BaseJob
  def perform(path, uid)
    logger.info "job=SetRecursiveFilePermissions path=#{path} uid=#{uid}"
    SoulOwner.file_utils.tap do |fs|
      fs.chown_R uid.to_i, SoulOwner.gid, path
      fs.chmod_R desired_permissions_for_path(path), path
    end
  end

  def desired_permissions_for_path(path)
    if File.file? path
      SoulOwner::FILE_PERMISSIONS
    else
      SoulOwner::DIR_PERMISSIONS
    end
  end
end