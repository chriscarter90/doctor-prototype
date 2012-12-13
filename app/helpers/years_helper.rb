module YearsHelper
  def start_date(term)
    term.start_date.strftime("%-d %B %Y")
  end
end
