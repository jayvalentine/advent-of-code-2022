require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/message'

class MessageTest < Test::Unit::TestCase
    def test_is_packet_marker()
        m = Message::is_packet_marker?("agtr")
        assert(m)
    end

    def test_is_not_packet_marker()
        m = Message::is_packet_marker?("afrf")
        assert_false(m)
    end

    def test_is_not_packet_marker_too_small()
        m = Message::is_packet_marker?("aef")
        assert_false(m)
    end

    def test_is_message_marker()
        m = Message::is_message_marker?("abcdepotijklzx")
        assert(m)
    end

    def test_is_not_message_marker()
        m = Message::is_message_marker?("abctepotijklzx")
        assert_false(m)
    end

    def test_is_not_message_marker_too_small()
        m = Message::is_message_marker?("tople")
        assert_false(m)
    end
end
