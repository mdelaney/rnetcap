require './protocols/ethernet/mac_address'

include Protocol::Ethernet2

module Protocol
  module Ethernet2
    class Frame
      attr_accessor :destination, :source, :type, :data, :crc

      def initialize(destination, source, type, data, crc)
        @destination = MacAddress.new destination.unpack 'C6'
        @source = MacAddress.new source.unpack 'C6'
        @type = type
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
        header = packet.unpack "a6 a6 n a#{packet.length - 18} N"
        # TODO: we should probably check the crc and throw an exception if its invalid
        Frame.new(*header)
      end

      # returns true if the crc is valid for the given frame
      # if its not valid then there is either an error in the frame or the crc
      def crc_valid?
      end

      # the type is a 16 bit uint
      # this can be set by passing the 16 bit uint or a two byte array
      def set_type(bytes)
        #if bytes.is_a? Integer
        #  if bytes < 0 or bytes > 0xFFFF
        #    raise
      end

      def to_s
        type = @type.map {|i| i.to_s(16).rjust(2, '0').upcase}
        crc = @crc.map {|i| i.to_s(16).rjust(2, '0').upcase}

        "destination: #{@destination}\n" +
        "source: #{@source}\n" +
        "type: #{type}\n" +
        "crc: #{crc}\n"
      end
    end
  end
end

