class YearsController < ApplicationController
  def index
    @years = Year.in_order
  end

  def new
    @year = Year.new
    3.times do
      @year.terms.build
    end
    @terms = @year.terms
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
end
