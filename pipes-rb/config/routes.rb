Rails.application.routes.draw do
  resources :flows, only: [:create, :show], param: :flow_tag
end
