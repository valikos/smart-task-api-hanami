module RequestMethodHelpers
  HEADERS = { "CONTENT_TYPE" => "application/json" }

  def xhr_get(endpoint, params, authorization = nil)
    url = if params.length
      "#{endpoint}?#{query_params(params)}"
    else
      endpoint
    end

    get(url, {}, HEADERS)
  end

  def xhr_post(endpoint, params = {}, authorization = nil)
    post(endpoint, params.to_json, request_headers(auth: authorization))
  end

  def xhr_put(endpoint, params = {}, authorization = nil)
    put(endpoint, params.to_json, request_headers(auth: authorization))
  end

  def xhr_patch(endpoint, params = {}, authorization = nil)
    patch(endpoint, params.to_json, request_headers(auth: authorization))
  end

  def xhr_delete(endpoint, authorization = nil)
    delete(endpoint, {}.to_json, request_headers(auth: authorization))
  end

  private

  def request_headers(options = {})
    { "CONTENT_TYPE" => "application/json",
      "HTTP_AUTHORIZATION" => options[:auth] }
  end

  def query_params(params)
    Rack::Utils.build_query(params)
  end
end
