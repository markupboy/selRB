#!/usr/bin/env ruby
class PostDiscussionTest < SeleniumTest

  def test_post_discussion_from_home_page
    browser.open "/"
    assertTitle "Google"
    assertElementPresent "q"
    browser.type "q", "git"
    browser.click "btnG", :wait_for => :page
    assertTitle "git - Google Search"

    # browser.click "link=login", :wait_for => :page
    # assertElementPresent("UserID")
    # assertElementPresent("Password")
    # 
    # browser.type("Password", TEST_CONFIG['community_password'])
    # browser.click "//input[@value='log in now']"
    # sleep 45
    # assertTextPresent("edit profile", "Failed to successfully log in")
    # browser.click "link=Ask the Members", :wait_for => :element, :element => 'form_well'
    # browser.click "submit", :wait_for => :element, :element => 'css=.sysmessage'
    # verifyTextPresent("Select a topic")
    # verifyTextPresent("Subject can not be empty")
    # verifyTextPresent("Message can not be empty")
    # browser.click "css=.sysmessage-close a"
    # sleep 5
    # verifyElementNotPresent("css=.sysmessage")
    # browser.select "topic", "label=Technology"
    # browser.click "submit", :wait_for => :element, :element => 'css=.sysmessage'
    # verifyElementPresent("css=.sysmessage")
    # verifyTextNotPresent("Select a topic")
    # verifyTextPresent("Subject can not be empty")
    # verifyTextPresent("Message can not be empty")
    # browser.click "css=.sysmessage-close a"
    # sleep 5
    # verifyElementNotPresent("css=.sysmessage")
    # browser.type "subject", "selenium test"
    # browser.click "submit", :wait_for => :element, :element => 'css=.sysmessage'
    # verifyElementPresent("css=.sysmessage")
    # verifyTextNotPresent("Select a topic")
    # verifyTextNotPresent("Subject can not be empty")
    # verifyTextPresent("Message can not be empty")
    # browser.click "css=.sysmessage-close a"
    # sleep 5
    # verifyElementNotPresent("css=.sysmessage")
    # browser.type "message", "selenium test"
    # browser.click "submit", :wait_for => :page
    # assert_equal browser.text("xpath=/html/body/div[2]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/h3"), "selenium test"
    # assert_equal browser.text("xpath=/html/body/div[2]/div/div[2]/div/div[2]/div/div/div[2]/div[2]/div/p"), "selenium test"
  end

end