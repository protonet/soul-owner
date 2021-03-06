require 'logger'
require 'fileutils'

module SoulOwner
  FILE_PERMISSIONS = 0660
  DIR_PERMISSIONS  = 0770

  class << self
    def file_utils
      @file_utils ||= FileUtils
    end
    # Allow to inject a different permissions class for testing
    attr_writer :file_utils

    def gid
      @gid ||= Etc.getgrnam('protonet').gid
    end
    # Allow to set a different gid for testing
    attr_writer :gid

    def logger
      @logger ||= Logger.new STDOUT
    end

    def env
      ENV.fetch 'RACK_ENV'
    end
  end

  autoload :BaseJob, "jobs/base_job"
  autoload :SetFilePermissionsAfterUpload, "jobs/set_file_permissions_after_upload"
  autoload :SetRecursiveFilePermissions, "jobs/set_recursive_file_permissions"
  autoload :Api, "api"
end