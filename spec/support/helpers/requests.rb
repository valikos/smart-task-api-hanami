# module Requests
#   HEADERS = { "CONTENT_TYPE" => "application/json" }

#   def api_get(endpoint, params = {})
#     url = if params.length
#       "#{endpoint}?#{query_params(params)}"
#     else
#       endpoint
#     end

#     get(url, {}, HEADERS)
#   end

#   def api_post(endpoint, params = {})
#     url = if params.length
#       "#{endpoint}?#{query_params(params)}"
#     else
#       endpoint
#     end

#     post(url, {}, HEADERS)
#   end

#   private

#   def query_params(params)
#     Rack::Utils.build_query(params)
#   end
# end
