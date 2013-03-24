require 'importer'

namespace :import do
  desc "Import requirements"
  task :requirements => [:environment, :classes] do
    Importer.import_requirements
  end

  desc "Import lecturers"
  task :lecturers => [:environment, :staff] do
    Importer.import_lecturers
  end

  desc "Import all"
  task :all => [:requirements, :lecturers]
end
