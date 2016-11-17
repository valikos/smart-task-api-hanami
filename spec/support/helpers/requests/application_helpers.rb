module ApplicationHelpers
  def self.inluded(group)
    group.define_singleton_method :app do
      @app ||= Hanami.app
    end
  end
end
