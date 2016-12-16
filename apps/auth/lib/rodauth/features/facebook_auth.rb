# frozen-string-literal: true

module Rodauth
  FacebookAuth = Feature.define(:facebook_auth) do
    depends :login
  end
end
