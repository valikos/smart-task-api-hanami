# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
#
# Prooject actions
get    '/projects',     to: 'project#index'
get    '/projects/:id', to: 'project#show'
post   '/projects',     to: 'project#create'
patch  '/projects/:id', to: 'project#update'
delete '/projects/:id', to: 'project#destroy'
