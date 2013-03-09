require 'spec_helper'

describe CourseWeeksController do
  describe "index" do
    before :each do
      @year = FactoryGirl.build(:year)
      @year.terms = [
                      FactoryGirl.create(:term, :no => 1, :year => @year),
                      FactoryGirl.create(:term, :no => 3, :year => @year),
                      FactoryGirl.create(:term, :no => 2, :year => @year)
                    ]
      @year.save!

      @c1 = FactoryGirl.create(:lecture_course, :code => "123B")
      @c2 = FactoryGirl.create(:lecture_course, :code => "101")

      get :index, :year_id => @year
    end

    it "should assign @year with the correct year" do
      assigns(:year).should == @year
    end

    it "should assign @terms with the terms for the year (in order)" do
      assigns(:terms).size.should == 3
      assigns(:terms).map(&:no).should == [1, 2, 3]
    end

    it "should assign @courses with all of the courses (in order)" do
      debugger
      assigns(:courses).should == [@c2, @c1]
    end
  end

  describe "update" do
    before :each do
      @year = FactoryGirl.build(:year)
      @year.terms = [
                      FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :year => @year),
                      FactoryGirl.create(:term, :no => 3, :no_weeks => 6, :year => @year),
                      FactoryGirl.create(:term, :no => 2, :no_weeks => 5, :year => @year)
                    ]
      @year.save!

      @c1 = FactoryGirl.create(:lecture_course, :code => "123B", :term => "1")
      @c2 = FactoryGirl.create(:lecture_course, :code => "101", :term => "2")

      @staff1 = FactoryGirl.create(:staff_member, :login => "abc123", :salutation => "Dr", :firstname => "Testy", :lastname => "McTest")
      @staff2 = FactoryGirl.create(:staff_member, :login => "zyx987", :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein")
      @staff3 = FactoryGirl.create(:staff_member, :login => "jkl456", :salutation => "Prof", :firstname => "Doc", :lastname => "Tor")

      FactoryGirl.create(:lecturer, :staff_member => @staff1, :lecture_course => @c1, :role => "Lecturer")
      FactoryGirl.create(:lecturer, :staff_member => @staff2, :lecture_course => @c1, :role => "Lecturer")
      FactoryGirl.create(:lecturer, :staff_member => @staff3, :lecture_course => @c1, :role => "Organiser")
      FactoryGirl.create(:lecturer, :staff_member => @staff2, :lecture_course => @c2, :role => "Lecturer")
    end

    it "should assign @year with the correct year" do
      get :update, :year_id => @year

      assigns(:year).should == @year
    end

    it "should clear out all week allocations for that year with blank params" do
      get :update, :year_id => @year

      @year.course_weeks.should be_empty
      @c1.course_weeks.for_year(@year).should be_empty
      @c2.course_weeks.should be_empty
      @staff1.course_weeks.should be_empty
      @staff2.course_weeks.should be_empty
      @staff3.course_weeks.should be_empty
    end

    it "should create allocations based on the params if everything is valid" do
      get :update, :year_id => @year, :course_weeks => {
        "123B" => {
          "lectures" => {
            "abc123" => {
              "1" => {
                "1" => "2",
                "2" => "3",
                "3" => "3",
                "4" => "2",
              }
            },
            "zyx987" => {
              "1" => {
                "1" => "3",
                "2" => "2",
                "3" => "2",
                "4" => "3",
              }
            }
          },
          "tutorials" => {
            "1" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          },
          "labs" => {
            "1" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          }
        }
      }


      @year.course_weeks.for_year(@year).size.should == 16
      @c1.course_weeks.size.should == 16
      @c2.course_weeks.size.should == 0
      @staff1.course_weeks.size.should == 4
      @staff2.course_weeks.size.should == 4
      @staff3.course_weeks.size.should == 0
    end

    it "should not create an allocation for a week which doesn't exist within the term" do
      get :update, :year_id => @year, :course_weeks => {
        "123B" => {
          "lectures" => {
            "abc123" => {
              "1" => {
                "5" => "2"
              }
            },
            "zyx987" => {
              "1" => {
                "5" => "2"
              }
            }
          },
          "tutorials" => {
            "1" => {
              "5" => "2"
            }
          },
          "labs" => {
            "1" => {
              "5" => "2"
            }
          }
        }
      }

      @year.course_weeks.for_year(@year).size.should == 0
      @c1.course_weeks.size.should == 0
      @c2.course_weeks.size.should == 0
      @staff1.course_weeks.size.should == 0
      @staff2.course_weeks.size.should == 0
      @staff3.course_weeks.size.should == 0
    end

    it "should not create an allocation for a term in which the course is not meant to be taught" do
      get :update, :year_id => @year, :course_weeks => {
        "123B" => {
          "lectures" => {
            "abc123" => {
              "2" => {
                "1" => "2",
                "2" => "3",
                "3" => "3",
                "4" => "2",
              }
            },
            "zyx987" => {
              "2" => {
                "1" => "3",
                "2" => "2",
                "3" => "2",
                "4" => "3",
              }
            }
          },
          "tutorials" => {
            "2" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          },
          "labs" => {
            "2" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          }
        }
      }

      @year.course_weeks.for_year(@year).size.should == 0
      @c1.course_weeks.size.should == 0
      @c2.course_weeks.size.should == 0
      @staff1.course_weeks.size.should == 0
      @staff2.course_weeks.size.should == 0
      @staff3.course_weeks.size.should == 0
    end

    it "should update the merged_lecturers attribute on the course when provided" do
      @c1.merged_lecturers.should be_false

      get :update, :year_id => @year, :course_weeks => {
        "123B" => {
          "merged_lecturers" => "true"
        }
      }

      @c1.reload
      @c1.merged_lecturers.should be_true

      get :update, :year_id => @year, :course_weeks => {
        "123B" => { }
      }

      @c1.reload
      @c1.merged_lecturers.should be_false
    end

    it "should ignore the lecture parameters for individual lecturers if they should be merged" do
      get :update, :year_id => @year, :course_weeks => {
        "123B" => {
          "merged_lecturers" => "true",
          "lectures" => {
            "abc123" => {
              "1" => {
                "1" => "2",
                "2" => "3",
                "3" => "3",
                "4" => "2",
              }
            },
            "zyx987" => {
              "1" => {
                "1" => "3",
                "2" => "2",
                "3" => "2",
                "4" => "3",
              }
            },
            "all" => {
              "1" => {
                "1" => "3",
                "2" => "2",
                "3" => "2",
                "4" => "3",
              }
            }
          },
          "tutorials" => {
            "1" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          },
          "labs" => {
            "1" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          }
        }
      }

      @year.course_weeks.for_year(@year).size.should == 12
      @c1.course_weeks.size.should == 12
      @c2.course_weeks.size.should == 0
      @staff1.course_weeks.size.should == 0
      @staff2.course_weeks.size.should == 0
      @staff3.course_weeks.size.should == 0
    end

    it "should ignore the lecture parameters for merged lecturers if they should not be merged" do
      get :update, :year_id => @year, :course_weeks => {
        "123B" => {
          "lectures" => {
            "abc123" => {
              "1" => {
                "1" => "2",
                "2" => "3",
                "3" => "3",
                "4" => "2",
              }
            },
            "zyx987" => {
              "1" => {
                "1" => "3",
                "2" => "2",
                "3" => "2",
                "4" => "3",
              }
            },
            "all" => {
              "1" => {
                "1" => "3",
                "2" => "2",
                "3" => "2",
                "4" => "3",
              }
            }
          },
          "tutorials" => {
            "1" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          },
          "labs" => {
            "1" => {
              "1" => "1",
              "2" => "1",
              "3" => "1",
              "4" => "1",
            }
          }
        }
      }

      @year.course_weeks.for_year(@year).size.should == 16
      @c1.course_weeks.size.should == 16
      @c2.course_weeks.size.should == 0
      @staff1.course_weeks.size.should == 4
      @staff2.course_weeks.size.should == 4
      @staff3.course_weeks.size.should == 0
    end
  end
end
