DoctorPrototype::Application.routes.draw do

  root :to => 'years#index'

  put 'years/:year_id/course_weeks',
    :to => 'course_weeks#update',
    :as => :update_course_weeks

  put 'years/:year_id/clashes',
    :to => 'clashes#update',
    :as => :update_clashes

  delete 'years/:year_id/unclashables',
    :to => 'unclashables#remove',
    :as => :remove_unclashable

  resources :years, :except => [:destroy] do
    resources :rooms, :except => [:show]
    resources :degree_classes, :only => [:index, :show] do
      collection do
        post 'import'
      end
    end
    resources :staff_members, :only => [:index, :show] do
      collection do
        post 'import'
      end
    end
    resources :lecture_courses, :only => [:index, :show], :constraints => { :id => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ } do
      member do
        post 'show_clashes'
        delete 'hide_clashes'
      end
      collection do
        post 'import'
      end
    end
    resources :course_weeks, :only => [:index]
    resources :clashes, :only => [:index, :new]
    resources :unclashables, :only => [:create]
  end
end
