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

ActiveRecord::Schema.define(:version => 20130530154636) do

  create_table "clashes", :force => true do |t|
    t.integer  "year_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clashes_lecture_courses", :force => true do |t|
    t.integer "clash_id"
    t.integer "lecture_course_id"
  end

  create_table "course_weeks", :force => true do |t|
    t.integer  "week_id"
    t.integer  "lecture_course_id"
    t.integer  "staff_member_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "hours"
    t.string   "session_type"
  end

  add_index "course_weeks", ["week_id", "lecture_course_id", "staff_member_id", "session_type"], :name => "as_week_course_staff_type", :unique => true

  create_table "days", :force => true do |t|
    t.integer  "no"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "degree_classes", :force => true do |t|
    t.string   "degreeyr"
    t.string   "letteryr"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year_id"
  end

  add_index "degree_classes", ["degreeyr", "year_id"], :name => "index_degree_classes_on_degreeyr_and_year_id", :unique => true

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
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "merged_lecturers", :default => false, :null => false
    t.integer  "year_id"
    t.boolean  "clashes_hidden"
    t.string   "scheduling_type"
    t.string   "size"
  end

  add_index "lecture_courses", ["code", "year_id"], :name => "index_lecture_courses_on_code_and_year_id", :unique => true

  create_table "lecture_courses_unclashables", :force => true do |t|
    t.integer "unclashable_id"
    t.integer "lecture_course_id"
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
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "year_id"
    t.string   "room_type",  :default => "lecture", :null => false
    t.string   "size",       :default => "large",   :null => false
  end

  add_index "rooms", ["no", "year_id"], :name => "index_rooms_on_no_and_year_id", :unique => true

  create_table "staff_members", :force => true do |t|
    t.string   "login"
    t.string   "salutation"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year_id"
  end

  add_index "staff_members", ["login", "year_id"], :name => "index_staff_members_on_login_and_year_id", :unique => true

  create_table "terms", :force => true do |t|
    t.integer  "year_id"
    t.integer  "no"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "start_date"
  end

  add_index "terms", ["year_id", "no"], :name => "index_terms_on_year_id_and_no", :unique => true

  create_table "time_slots", :force => true do |t|
    t.integer  "day_id"
    t.integer  "start_hour"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "time_slots", ["day_id", "start_hour"], :name => "index_time_slots_on_day_id_and_start_hour", :unique => true

  create_table "timetable_slots", :force => true do |t|
    t.integer  "room_id"
    t.integer  "time_slot_id"
    t.integer  "lecture_course_id"
    t.integer  "week_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "timetable_slots", ["room_id", "time_slot_id", "week_id"], :name => "index_timetable_slots_on_room_id_and_time_slot_id_and_week_id", :unique => true

  create_table "unclashables", :force => true do |t|
    t.integer  "year_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "weeks", :force => true do |t|
    t.integer  "term_id"
    t.integer  "no"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date"
  end

  create_table "years", :force => true do |t|
    t.integer  "no"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "timetable_generated", :default => false
  end

end
