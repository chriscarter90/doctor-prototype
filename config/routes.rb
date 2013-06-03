DoctorPrototype::Application.routes.draw do

  root :to => 'years#index'

  put 'years/:year_id/clashes',
    :to => 'clashes#update',
    :as => :update_clashes

  delete 'years/:year_id/unclashables',
    :to => 'unclashables#remove',
    :as => :remove_unclashable

  put 'years/:id/generate_timetable',
    :to => 'years#generate_timetable',
    :as => :year_generate_timetable

  resources :years, :except => [:destroy] do
    resources :requirements, :only => [] do
      collection do
        post 'import'
      end
    end
    resources :precisely_clauses, :only => [:index] do
      collection do
        put 'update'
      end
    end
    resources :preference_clauses, :only => [:index] do
      collection do
        put 'update'
      end
    end
    resources :terms, :only => [] do
      member do
        get 'timetable_slots'
      end
    end
    resources :lecturers, :only => [] do
      collection do
        post 'import'
      end
    end
    resources :rooms, :except => [:show] do
      member do
        get 'timetable_slots'
      end
    end
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
        put 'update_course_weeks'
      end
      collection do
        post 'import'
      end
    end
    resources :clashes, :only => [:index, :new]
    resources :unclashables, :only => [:create]
    resources :timetable_slots, :only => [:index]
  end
end
