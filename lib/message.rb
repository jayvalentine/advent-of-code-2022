module Message
    def self.is_start?(s)
        # Can't be a start marker if we have fewer than 4 chars.
        return false if s.size < 4

        # Check if all characters in the string occur exactly once.
        s.chars.all? { |c| s.count(c) == 1 }
    end
end