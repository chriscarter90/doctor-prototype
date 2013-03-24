require 'importer'

namespace :import do
  desc "Import lecturers"
  task :lecturers => [:environment, :staff] do
    Importer.import_lecturers
  end

  desc "Import all"
  task :all => [:requirements, :lecturers]
end
