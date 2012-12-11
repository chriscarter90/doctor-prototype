class YearsController < ApplicationController
  def index
    @years = Year.in_order
  end
end
