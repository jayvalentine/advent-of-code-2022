require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/message'

class MessageTest < Test::Unit::TestCase
    def test_is_marker()
        m = Message::is_start?("agtr")
        assert(m)
    end

    def test_is_not_marker()
        m = Message::is_start?("afrf")
        assert_false(m)
    end

    def test_is_not_marker_too_small()
        m = Message::is_start?("aef")
        assert_false(m)
    end
end
