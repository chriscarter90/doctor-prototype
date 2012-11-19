require 'importer'

namespace :import do
  desc "Import degree classes"
  task :classes => :environment do
    Importer.import_classes
  end

  desc "Import lecture courses"
  task :courses => :environment do
    Importer.import_courses
  end

  desc "Import staff members"
  task :staff => :environment do
    Importer.import_staff
  end

  desc "Import requirements"
  task :requirements => [:environment, :classes, :courses] do
    Importer.import_requirements
  end

  desc "Import lecturers"
  task :lecturers => [:environment, :courses, :staff] do
    Importer.import_lecturers
  end

  desc "Import all"
  task :all => [:requirements, :lecturers]
end
