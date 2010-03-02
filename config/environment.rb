# SETS ENVIRONMENT AGAINST WHICH TO RUN TEST
TEST_ENV = 'dev' unless defined?(TEST_ENV)
TEST_BROWSERS = ["*safari"]

TEST_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(TEST_ROOT)
require File.join(TEST_ROOT, 'config', 'initializers', 'load_config')
require File.join(TEST_ROOT, 'lib', 'SeleniumTest.rb')
