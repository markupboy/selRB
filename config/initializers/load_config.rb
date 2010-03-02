require 'yaml'

raw_config = File.read(TEST_ROOT + "/config/config.yml")
TEST_CONFIG = YAML.load(raw_config)[TEST_ENV]