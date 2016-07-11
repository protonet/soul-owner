require 'logger'
require 'fileutils'

module SoulOwner
  class << self
    def file_utils
      FileUtils
    end

    def logger
      @logger ||= Logger.new STDOUT
    end

    def env
      ENV.fetch 'RACK_ENV'
    end
  end

  autoload :BaseJob, "jobs/base_job"
  autoload :SetFilePermissionsAfterUpload, "jobs/set_file_permissions_after_upload"
  autoload :SetRecursiveFilePermissionsJob, "jobs/set_recursive_file_permissions"
end