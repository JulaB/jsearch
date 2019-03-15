Rails.application.routes.draw do
  root 'search#index'

  get 'search/index'
end
