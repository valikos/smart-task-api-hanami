class BaseSerializer
  include JSONAPI::Serializer

  def base_url
    "#{ENV['HOST_URL']}/api"
  end
end
