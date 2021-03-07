# frozen_string_literal: true

Rails.application.routes.draw do
  resources :owners do
    resources :houses
  end

  post 'create_from_link', to: 'owners#create_from_link'
end
