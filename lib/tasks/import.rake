require 'importer'

namespace :import do
  desc "Import all"
  task :all => [:requirements, :lecturers]
end
