module Message
    def self.all_unique?(s)
        # Check if all characters in the string occur exactly once.
        s.chars.all? { |c| s.count(c) == 1 }
    end

    def self.is_packet_marker?(s)
        # Can't be a start marker if we have fewer than 4 chars.
        return false if s.size < 4

        self.all_unique?(s)
    end

    def self.is_message_marker?(s)
        # Can't be a start marker if we have fewer than 14 chars.
        return false if s.size < 14

        self.all_unique?(s)
    end
end