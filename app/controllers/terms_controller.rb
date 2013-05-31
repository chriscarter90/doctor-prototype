class TermsController < ApplicationController
  def timetable_slots
    @year = Year.find_by_no(params[:year_id])
    @term = @year.terms.find_by_no(params[:id])
    @time_slots = TimeSlot.scoped
    @slots = []
    @term.weeks.each do |w|
      @slots << @year.timetable_slots.where(:week_id => w.id)
    end
    @slots = group_slots(@slots.flatten)
  end

  private
  def group_slots(slots)
    by_time_slot = slots.group_by { |s| s.time_slot }
    by_time_slot_and_course = {}
    by_time_slot.each_pair do |slot, slot_allocs|
      by_time_slot_and_course[slot] = slot_allocs.group_by { |s| s.lecture_course }
      by_time_slot_and_course[slot].each_pair do |course, course_allocs|
        by_time_slot_and_course[slot][course] = course_allocs.group_by { |c| c.slot_type }
        by_time_slot_and_course[slot][course].each_pair do |type, type_allocs|
          by_time_slot_and_course[slot][course][type] = type_allocs.group_by { |t| t.room }
        end
      end
    end
    by_time_slot_and_course
  end
end
