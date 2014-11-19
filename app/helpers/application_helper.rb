module ApplicationHelper
  def invalid_browser?
    browser.ie6? || browser.ie7? || browser.ie8?
  end
end
