module SetActiveStorageUrl
  extend ActiveSupport::Concern

  included do
    before_action :set_active_storage_url_options
  end

  private

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = {
      protocol: request.protocol,
      host: request.host,
      port: request.port
    }
  end
end
