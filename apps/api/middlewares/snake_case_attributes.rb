class SnakeCaseAttributes

  PATTERN = /-/

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    router_params = request.env.fetch('router.params', false)

    if router_params
      request.env['router.params'][:data][:attributes] = parse_attributes(
        router_params[:data][:attributes]
      )
    end

    @app.call(request.env)
  end

  private

  def parse_attributes(attributes)
    snake_attributes = {}

    attributes.each_pair do |k, _|
      stringify_key = k.to_s
      if stringify_key.match(PATTERN)
        snake_key = stringify_key.gsub(PATTERN, '_')
        snake_attributes[snake_key.to_sym] = attributes.delete(k)
      end
    end

    attributes.merge(snake_attributes)
  end
end
