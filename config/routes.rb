DoctorPrototype::Application.routes.draw do

  root :to => 'lecture_courses#index'

  resources :lecture_courses, :only => [:index, :show]
  resources :degree_classes, :only => [:index, :show]

end
