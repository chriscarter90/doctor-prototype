class PreciselyClausesController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @precisely_file = File.read(Rails.root.join("ASP", @year.no.to_s, "precisely.lp"))
  end

  def update
    @year = Year.find_by_no(params[:year_id])
    File.open(Rails.root.join("ASP", @year.no.to_s, "precisely.lp"), "w") do |f|
      f.write(params["file_contents"])
    end
    redirect_to year_path(@year), :notice => "Precisely clauses were updated successfully."
  end
end
