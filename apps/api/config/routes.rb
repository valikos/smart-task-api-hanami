# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
#
# Project actions
get    '/projects',     to: 'project#index'
get    '/projects/:id', to: 'project#show'
post   '/projects',     to: 'project#create'
patch  '/projects/:id', to: 'project#update'
delete '/projects/:id', to: 'project#destroy'

# Task actions
get    '/projects/:project_id/tasks', to: 'tasks#index'
post   '/tasks',                      to: 'tasks#create'
delete '/tasks/:id',                  to: 'tasks#destroy'
patch  '/tasks/:id',                  to: 'tasks#update'

# Comment actions
post   '/comments',     to: 'comments#create'
delete '/comments/:id', to: 'comments#destroy'
