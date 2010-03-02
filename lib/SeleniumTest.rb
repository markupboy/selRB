#!/usr/bin/env ruby
require "test/unit"
require "rubygems"
gem "selenium-client", ">=1.2.16"
require "selenium/client"

# SeleniumTest is the basis for the entire testing harness.
# Every test created must inherit from this class.
# This class contains the default setup methods as well as assertion and verification definitions
# 
# :title:SeleniumTest

class SeleniumTest < Test::Unit::TestCase
  attr_reader :browser
  attr_reader :verification_errors

  # Necessary setup function defition required to use selenium
  def setup
    for test_browser in TEST_BROWSERS do
      @verification_errors = []
      @browser = Selenium::Client::Driver.new \
          :host => TEST_CONFIG['host'],
          :port => TEST_CONFIG['port'],
          :browser => test_browser,
          :url => TEST_CONFIG['url'],
          :timeout_in_second => TEST_CONFIG['timeout']

      browser.start_new_browser_session
    end
  end

  # Necessary teardown function defition required to use selenium
  def teardown
    browser.close_current_browser_session
    assert_equal [], verification_errors
  end
  
  # Default test
  def default_test
  end

  # Used to verify an assertion
  # 
  # Pushes the standard or set verification error on to the stack to be displayed when test is complete
  # Verifications should be used when tests aren't required to abort on failure
  # === Parameters
  # * _assertion_ = an assertion or assertion method to be verified
  # === Example
  # verify( lambda{ assert_equal "some text", browser.title })
  def verify(assertion)
    begin
      assertion.call
    rescue Test::Unit::AssertionFailedError
      verification_errors << $!
    end
  end
  
  # verify shorcut for assert_equal
  # === Parameters
  # * _arg1_ = value to be checked
  # * _arg2_ = value to check arg1 against
  # * _error_message_ = string to be used as additional error messaging in assertion
  def verifyEqual(arg1, arg2, error_message = nil)
    verify(lambda { assert_equal arg1, arg2, error_message })
  end
  
  # checks the title of a page against a known value
  def assertTitle(title, error_message = nil)
    assert_equal title, browser.title, error_message
  end
  
  # verifies the title of a page against a known value using assertTitle
  def verifyTitle(title, error_message = nil)
    verify(lambda { assertTitle(title, error_message) })
  end
  
  # checks that the specified element is somewhere on the page
  def assertElementPresent(element, error_message = "Failed to locate element " + element)
   assert browser.element?(element), error_message
  end
  
  # verifies that the specified element is somewhere on the page using assertElementPresent
  def verifyElementPresent(element, error_message = "Failed to locate element " + element)
    verify(lambda { assertElementPresent(element, error_message) })
  end
  
  # checks that the specified element is nowhere on the page
  def assertElementNotPresent(element, error_message = "Expected to not locate element " + element)
    assert !browser.element?(element), error_message
  end
  
  # verifies that the specified element is nowhere on the page using assertElementNotPresent
  def verifyElementNotPresent(element, error_message = "Expected to not locate element " + element)
    verify(lambda { assertElementNotPresent(element, error_message) })
  end
  
  # checks that the specified text is somewhere on the page
  def assertTextPresent(text, error_message = "Failed to locate text " + text)
    assert browser.text?(text), error_message
  end

  # verifies that the specified text is somewhere on the page using assertTextPresent
  def verifyTextPresent(text, error_message = "Failed to locate text " + text)
    verify(lambda { assertTextPresent(text, error_message) })
  end

  # checks that the specified text is nowhere on the page    
  def assertTextNotPresent(text, error_message = "Expected to not locate text " + text)
    assert !browser.text?(text), error_message
  end
  
  # verifies that the specified text is nowhere on the page using assertTextNotPresent
  def verifyTextNotPresent(text, error_message = "Expected to not locate text " + text)
    verify(lambda { assertTextNotPresent(text, error_message) })
  end
  
  # checks that the message of the most recent alert matches the specified text
  def assertAlert(text, error_message = nil)
    assert_equal text, browser.get_alert, error_message
  end
  
  # verifies that the message of the most recent alert matches the specified text using assertAlert
  def verifyAlert(text, error_message = nil)
    verifyAlert(lambda { assertAlert(text, error_message) })
  end
  
  # checks if there is an alert
  def assertAlertPresent(error_message = nil)
    assert browser.is_alert_present, error_message
  end
  
  # verifies if there is an alert using assertAlertPresent
  def verifyAlertPresent(error_message = nil)
    verify(lambda { assertAlertPresent(error_message) })
  end
  
  # checks if there is not an alert
  def assertAlertNotPresent(error_message = nil)
    assert !browser.is_alert_present, error_message
  end
  
  # verifies if there is not an alert using assertAlertNotPresent
  def verifyAlertNotPresent(error_message = nil)
    verify(lambda { assertAlertNotPresent(error_message) })
  end
  
  # checks the value of the specified attribute against a known value
  def assertAttribute(attribute_locator, value, error_message = nil)
    assert_equal value, browser.get_attribute(attribute_locator), error_message
  end

  # verifies the value of the specified attribute against a known value using assertAttribute
  def verifyAttribute(attribute_locator, value, error_message = nil)
    verify(lambda { assertAttribute(attribute_locator, value, error_message) })
  end
  
  # checks if the specified element is checked
  def assertChecked(locator, error_message = nil)
    assert browser.is_checked(locator), error_message
  end

  # verifies if the specified element is checked using assertChecked
  def verifyChecked(locator, error_message = nil)
    verify(lambda { assertChecked(locator, error_message) })
  end
  
  # checks if the specified element is not checked
  def assertNotChecked(locator, error_message = nil)
    assert !browser.is_checked(locator), error_message
  end

  # verifies if the specified element is not checked using assertNotChecked
  def verifyNotChecked(locator, error_message = nil)
    verify(lambda { assertChecked(locator, error_message) })
  end
  
  # checks the value of a cookie (located by that cookie's name) is equal to a known value 
  def assertCookie(name, value, error_message = nil)
    assert_equal value, browser.get_cookie_by_name(name), error_message
  end
  
  # verifies the value of a cookie (located by that cookie's name) is equal to a known value  using assertCookie
  def verifyCookie(name, value, error_message = nil)
    verify(lambda { assertCookie(name, value, error_message) })
  end
  
  # checks if a cookie (located by that cookie's name) is present
  def assertCookiePresent(name, error_message = nil)
    assert browser.is_cookie_present(name), error_message
  end

  # verifies if a cookie (located by that cookie's name) is present using assertCookiePresent
  def verifyCookiePresent(name, error_message = nil)
    verify(lambda { assertCookiePresent(name, error_message) })
  end
  
  # checks if a cookie (located by that cookie's name) is not present
  def assertCookieNotPresent(name, error_message = nil)
    assert !browser.is_cookie_present(name), error_message
  end

  # verifies if a cookie (located by that cookie's name) is not present using assertCookieNotPresent
  def verifyCookieNotPresent(name, error_message = nil)
    verify(lambda { assertCookieNotPresent(name, error_message) })
  end
  
  # checks if the browsers current location (fully-qualified url) is equal to a known value
  def assertLocation(url, error_message = nil)
    assert_equal url, browser.get_location, error_message
  end

  # verifies if the browsers current location (fully-qualified url) is equal to a known value using assertLocation
  def verifyLocation(url, error_message = nil)
    verify(lambda { assertLocation(url, error_message) })
  end
  
  # checks if a specified select box contains a set of options equal to a known list
  def assertSelectOptions(locator, value, error_message = nil)
    assert_equal value, browser.get_select_options(locator).join(","), error_message
  end

  # verifies if a specified select box contains a set of options equal to a known list using assertSelectOptions
  def verifySelectOptions(locator, value, error_message = nil)
    verify(lambda { assertSelectOptions(locator, value, error_message) })
  end
  
  # checks if the label of the selected option in the specified select box is equal to a known value
  def assertSelectedLabel(locator, value, error_message = nil)
    assert_equal value, browser.get_selected_lable(locator), error_message
  end

  # verifies if the label of the selected option in the specified select box is equal to a known value using assertSelectedLabel
  def verifySelectedLabel(locator, value, error_message = nil)
    verify(lambda { assertSelectedLabel(locator, value, error_message) })
  end
  
  # checks if the value of the selected option in the specified select box is equal to a known value
  def assertSelectedValue(locator, value, error_message = nil)
    assert_equal value, browser.get_selected_value(locator), error_message
  end

  # verifies if the value of the selected option in the specified select box is equal to a known value using assertSelectedValue
  def verifySelectedValue(locator, value, error_message = nil)
    verify(lambda { assertSelectedValue(locator, value, error_message) })
  end
  
  # checks if an option is selected in the specified select box
  def assertSomethingSelected(locator, error_message = nil)
    assert browser.is_something_selected(locator), error_message
  end

  # verifies if an option is selected in the specified select box using assertSomethingSelected
  def verifySomethingSelected(locator, error_message = nil)
    verify(lambda { assertSomethingSelected(locator, error_message) })
  end
  
  # checks if the value of an element (most likely a form input) is equal to a known value
  def assertValue(locator, value, error_message = nil)
    assert_equal value, browser.get_value(locator), error_message
  end

  # verifies if the value of an element (most likely a form input) is equal to a known value using assertValue
  def verifyValue(locator, value, error_message = nil)
    verify(lambda { assertValue(locator, value, error_message) })
  end

  # checks if the specified element is visible
  def assertVisible(locator, error_message = nil)
    assert browser.is_visible(locator), error_message
  end

  # verifies if the specified element is visible using assertVisible
  def verifyVisible(locator, error_message = nil)
    verify(lambda { assertVisible(locator, error_message) })
  end
  
  # checks if the specified element is not visible
  def assertNotVisible(locator, error_message = nil)
    assert !browser.is_visible(locator), error_message
  end

  # verifies if the specified element is not visible using assertNotVisible
  def verifyNotVisible(locator, error_message = nil)
    verify(lambda { assertNotVisible(locator, error_message) })
  end

end