module Protocol
  module Ethernet2
    class Frame
      attr_accessor :destination, :source, :type, :data
    
      def initialize(destination, source, type, data, crc)
        @destination = destination
        @source = source
        @type = type
        @data = data
        @crc = crc
      end
    
      def self.decode(packet)
        Frame.new(
          packet[0 ... 6],
          packet[6 ... 12],
          packet[12 ... 14],
          packet[14 ... packet.length - 4],
          packet[packet.length - 4 ... packet.length],
        )
      end
    
      def to_s
        dest = @destination.map {|i| i.to_s(16).rjust(2, '0').upcase}
        src = @source.map {|i| i.to_s(16).rjust(2, '0').upcase}
        type = @type.map {|i| i.to_s(16).rjust(2, '0').upcase}
        crc = @crc.map {|i| i.to_s(16).rjust(2, '0').upcase}

        "destination: #{dest}\n" +
        "source: #{src}\n" +
        "type: #{type}\n" +
        "crc: #{crc}\n"
      end
    end
  end
end

