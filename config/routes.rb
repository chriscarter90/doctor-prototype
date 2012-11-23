DoctorPrototype::Application.routes.draw do

  root :to => 'home#index'

  resources :lecture_courses, :only => [:index, :show]
  resources :degree_classes, :only => [:index, :show]

end
