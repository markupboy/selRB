#!/usr/bin/env ruby
class GlobalLoggedOutTest < SeleniumTest

  def test_elements
    browser.open "/"
    global_elements = [
      "id=ghead",
      "id=logo",
      "f",
      "id=footer"
    ]
    global_elements.each { |element| 
      verifyElementPresent element
    }
  end

end