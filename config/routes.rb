Rails.application.routes.draw do
  # Root route.
  root   'tweets#index'

  # Tweet actions
  get    '/tweets' => 'tweets#index'
end
