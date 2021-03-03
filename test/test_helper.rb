$VERBOSE = nil

require File.expand_path("#{File.dirname __FILE__}/../../../test/test_helper")

module RedmineMentions
  class TestCase
    include ActionDispatch::TestProcess
  end
end
