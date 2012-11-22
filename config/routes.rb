DoctorPrototype::Application.routes.draw do

  root :to => 'lecture_courses#index'

  resources :lecture_courses, :only => [:index, :show]

end
