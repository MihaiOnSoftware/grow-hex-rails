# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tags
  resources :tasks
  get 'tags/index'
  get 'tags/show'
  get 'tags/create'
  get 'tags/update'
  get 'tags/destroy'
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/create'
  get 'tasks/update'
  get 'tasks/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
