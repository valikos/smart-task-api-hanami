module RequestMethodHelpers
  HEADERS = { "CONTENT_TYPE" => "application/json" }

  # [:get, :post, :put].each do |method|
  #   define_method "xhr_#{method}" do |endpoint, params, authorization = nil|
  #     url = if params.length
  #       "#{endpoint}?#{query_params(params)}"
  #     else
  #       endpoint
  #     end

  #     Rack::Test::Methods.send(method, url, {}, HEADERS)
  #   end
  # end

  def xhr_get(endpoint, params, authorization = nil)
    url = if params.length
      "#{endpoint}?#{query_params(params)}"
    else
      endpoint
    end

    get(url, {}, HEADERS)
  end

  def xhr_post(endpoint, params, authorization = nil)
    url = if params.length
      "#{endpoint}?#{query_params(params)}"
    else
      endpoint
    end

    post(url, {}, request_headers(auth: authorization))
  end

  def xhr_put(endpoint, params, authorization = nil)
    url = if params.length
      "#{endpoint}?#{query_params(params)}"
    else
      endpoint
    end

    put(url, {}, HEADERS)
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
