DoctorPrototype::Application.routes.draw do

  root :to => 'home#index'

  resources :lecture_courses, :only => [:index, :show], :constraints => { :id => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
  resources :degree_classes, :only => [:index, :show]
  resources :staff_members, :only => [:index, :show]
  resources :rooms, :except => [:show]

end
