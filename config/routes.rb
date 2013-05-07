Karate67272::Application.routes.draw do

  # Generated routes
  resources :events
  resources :registrations
  resources :sections
  resources :students
  resources :dojos
  resources :tournaments
  resources :sessions

  
  # Semi-static page routes
  match 'sections/:id/update_standings' => 'sections#update_standings', :as => :update_standings
  match 'sections/:id/edit_standings' => 'sections#edit_standings', :as => :edit_standings
  match 'sections/for_tournament/:id' => 'sections#for_tournament', :as => :for_tournament
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  match 'search' => 'home#search', :as => :search

  # Set the root url
  root :to => 'home#index'
  
end

