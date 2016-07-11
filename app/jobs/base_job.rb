# Base class for common async job functionality
class SoulOwner::BaseJob
  include SuckerPunch::Job

  private

    def logger
      SoulOwner.logger
    end
end