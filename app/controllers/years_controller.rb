class YearsController < ApplicationController
  def index
    @years = Year.in_order
  end

  def show
    @year = Year.find_by_no(params[:id])
    @terms = @year.terms.in_order
  end

  def new
    @year = Year.new
    3.times do
      @year.terms.build
    end
  end

  def create
    terms = params[:year].delete(:terms_attributes)
    @year = Year.new(params[:year])
    terms.each do |k, v|
      no_weeks = v.delete("no_weeks")
      t = @year.terms.build(v.merge(:year => @year))
      t.no_weeks = no_weeks.to_i
    end
    if @year.save
      redirect_to years_path, :notice => "Year was created successfully."
    else
      flash[:warning] = "Year could not be created."
      render :new
    end
  end

  def edit
    @year = Year.find_by_no(params[:id])
  end

  def update
    terms = params[:year].delete(:terms_attributes)
    @year = Year.find_by_no(params[:id])
    terms.each do |k, v|
      term_no = v.delete("no")
      term = @year.terms.find_by_no(term_no)
      term.start_date = v["start_date"]
      term.no_weeks = v["no_weeks"].to_i
      term.save
    end
    if @year.update_attributes(params[:year])
      redirect_to year_path(@year), :notice => "Year was updated successfully."
    else
      flash[:warning] = "Year could not be updated."
      render :edit
    end
  end
end
