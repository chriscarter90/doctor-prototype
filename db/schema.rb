# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121124182840) do

  create_table "degree_classes", :force => true do |t|
    t.string   "degreeyr"
    t.string   "letteryr"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lecture_courses", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "term"
    t.string   "classes"
    t.integer  "lecturehours"
    t.integer  "tutorialhours"
    t.integer  "labhours"
    t.integer  "weeklyhours"
    t.integer  "popestimate"
    t.integer  "popregistered"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "lecturers", :force => true do |t|
    t.integer  "lecture_course_id"
    t.integer  "staff_member_id"
    t.string   "role"
    t.integer  "staffhours"
    t.string   "term"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "lecturers", ["lecture_course_id", "staff_member_id", "role"], :name => "unique_lecturer", :unique => true

  create_table "requirements", :force => true do |t|
    t.integer  "lecture_course_id"
    t.integer  "degree_class_id"
    t.string   "required"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "requirements", ["lecture_course_id", "degree_class_id"], :name => "index_requirements_on_lecture_course_id_and_degree_class_id", :unique => true

  create_table "rooms", :force => true do |t|
    t.integer  "no"
    t.integer  "capacity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "staff_members", :force => true do |t|
    t.string   "login"
    t.string   "salutation"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
