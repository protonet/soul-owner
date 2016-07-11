# Base class for common job functionality
class SoulOwner::BaseJob
  private

    def logger
      SoulOwner.logger
    end
end