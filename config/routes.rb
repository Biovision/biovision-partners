# frozen_string_literal: true

Rails.application.routes.draw do
  concern :priority do
    post :priority, on: :member, defaults: { format: :json }
  end

  concern :toggle do
    post :toggle, on: :member, defaults: { format: :json }
  end

  concern :check do
    post :check, on: :collection, defaults: { format: :json }
  end

  resources :partners, only: %i[update destroy]

  scope '/(:locale)', constraints: { locale: /ru|en|sv|cn/ } do
    resources :partners, only: %i[new create edit], concerns: :check

    namespace :admin do
      resources :partners, only: %i[index show], concerns: %i[toggle priority]
    end
  end
end
