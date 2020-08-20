Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root "home#index"

  get 'home/index', to: 'home#index'
  # get 'home/dashboard', to: 'home#dashboard'

  # Users
  get 'user/:id', to: 'users#show'

  # Courses
  get 'courses/new', to: 'courses#new'
  get 'courses', to: 'courses#filtered_courses'
  get 'courses/dissolve/:id', to: 'courses#destroy', as: 'dissolve'
  post 'courses/new', to: 'courses#create_course', as: 'create'
  get 'courses/list', to: 'courses#index'
  get 'course/:id', to: 'courses#course'
  get 'apply/course/:course_id/:user_id', to: 'courses#apply_course', as: 'apply'
  get 'my_courses', to: 'courses#my_courses'

  # Manage Courses
  get 'admit/:student_id/:course_slug', to: 'courses#admit'
  get 'decline/:student_id/:course_slug', to: 'courses#admit'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
