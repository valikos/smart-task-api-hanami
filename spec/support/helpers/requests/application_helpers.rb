module ApplicationHelpers
  def app
    @app ||= Hanami::Container.new
  end
end
