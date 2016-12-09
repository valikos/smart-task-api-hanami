# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
#
# Project actions
get    '/projects',     to: 'projects#index'
get    '/projects/:id', to: 'projects#show'
post   '/projects',     to: 'projects#create'
patch  '/projects/:id', to: 'projects#update'
delete '/projects/:id', to: 'projects#destroy'

# Task actions
get    '/projects/:project_id/tasks', to: 'tasks#index'
post   '/tasks',                      to: 'tasks#create'
delete '/tasks/:id',                  to: 'tasks#destroy'
patch  '/tasks/:id',                  to: 'tasks#update'
