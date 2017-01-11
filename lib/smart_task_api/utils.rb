module SmartTaskApi
  module Utils
    def self.jwt_expiration(ttl = 15)
      Time.now.to_i + ttl * 3600
    end
  end
end
