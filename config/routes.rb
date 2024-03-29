DoctorPrototype::Application.routes.draw do

  root :to => 'home#index'

  put 'years/:year_id/course_weeks',
    :to => 'course_weeks#update',
    :as => :update_course_weeks

  put 'years/:year_id/clashes',
    :to => 'clashes#update',
    :as => :update_clashes

  resources :lecture_courses, :only => [:index, :show], :constraints => { :id => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
  resources :degree_classes, :only => [:index, :show]
  resources :staff_members, :only => [:index, :show]
  resources :rooms, :except => [:show]
  resources :years, :except => [:destroy] do
    resources :course_weeks, :only => [:index]
    resources :clashes, :only => [:index]
  end
end
