require './protocols/ethernet/mac_address'

include Protocol::Ethernet2

module Protocol
  module Ethernet2
    class Frame
      attr_accessor :destination, :source, :type, :data, :crc

      def initialize(destination, source, type, data, crc)
        @destination = MacAddress.new destination.unpack 'C6'
        @source = MacAddress.new source.unpack 'C6'
        self.frame_type = type
        @data = data
        @crc = crc
      end

      # here we decode the byte string as follows
      # 6 byte destination MAC address
      # 6 byte source MAC address
      # 2 byte type
      # some amount of data (the full byte string starting at the 15th byte
      #     and ending before the last 4 bytes
      # 4 byte crc
      def self.decode(packet)
        if packet.length < 18
          raise ArgumentError, "EthernetII frame is too short"
        end
        header = packet.unpack "a6 a6 n a#{packet.length - 18} N"
        # TODO: we should probably check the crc and throw an exception if its invalid
        Frame.new(*header)
      end

      # returns true if the crc is valid for the given frame
      # if its not valid then there is either an error in the frame or the crc
      def crc_valid?
      end

      # the type is a 16 bit uint
      # for this to be a valid ethernet 2 frame the value must be > 0x0600
      def frame_type=(value)
        if value <= 0x0600
          raise RangeError, "the EthernetII type value must be greater than 0x0600"
        elsif value > 0xFFFF
          raise RangeError, "EthernetII type must be less than or equal to 0xFFFF"
        end
        @type = value
      end

      def to_s
        type = @type.to_s(16).rjust(4, '0').upcase
        crc = @crc.to_s(16).rjust(8, '0').upcase

        "destination: #{@destination}\n" +
        "source: #{@source}\n" +
        "type: #{type}\n" +
        "crc: #{crc}\n"
      end
    end
  end
end

