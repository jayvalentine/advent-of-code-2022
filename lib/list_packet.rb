# Wrapper for a list that allows us to mix-in Comparable.
class ListPacket
    include Comparable

    attr_reader :list

    def initialize(list)
        @list = list
    end

    def to_s
        @list.inspect
    end

    def <=>(other)
        if @list.is_a?(Integer) && other.list.is_a?(Integer)
            @list <=> other.list
        elsif @list.is_a?(Array) && other.list.is_a?(Array)
            @list.each_with_index do |v, i|
                # If there is no corresponding element on the right side
                # to compare against, right is less than left
                if other.list[i].nil?
                    return 1
                end
    
                # If the elements of the two lists at this location are
                # in order, the packet is equal (so far).
                comparison = ListPacket.new(@list[i]) <=> ListPacket.new(other.list[i])
                unless comparison == 0
                    return comparison
                end
            end
    
            if @list.size < other.list.size
                return -1
            end
    
            # If we get to this point then we have compared all elements
            # of the arrays and found none that give us an indication of order.
            return 0
    
        elsif @list.is_a?(Integer) && other.list.is_a?(Array)
            ListPacket.new([@list]) <=> other
        elsif @list.is_a?(Array) && other.list.is_a?(Integer)
            self <=> ListPacket.new([other.list])
        else
            raise "Invalid types for left (#{left}, #{left.class}) or right (#{right}, #{right.class})"
        end
    end

    def self.parse(s)
        self.new(eval(s))
    end
end
