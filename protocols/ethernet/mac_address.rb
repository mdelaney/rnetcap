
module Protocol
  module Ethernet2
    class MacAddress
      # The address must be passed as either a byte array 6 bytes long (or some
      # other itrable class) or a string representation like "01:00:5E:7F:FF:FA"
      def initialize(address)
        @address = []
        if address.is_a? String
          set_address_by_string(address)
        else
          set_address_by_byte_array(address)
        end
      end

      # An array of 6 bytes should be passed to this function
      def set_address_by_byte_array(address)
        new_address = []
        if address.length != 6
          raise IndexError, "address Array must have 6 elements"
        end
        address.each do |e|
          if e < 0 or e > 255
            raise RangeError, "each element of address must be between 0 and 255 (1 byte)"
          end
          new_address << e
        end
        @address = new_address
      end

      def set_address_by_string(address)
        new_address = []
        str_array = address.split(":")
        if str_array.length != 6
          raise ArgumentError, "mac addresses must be in format like 00:01:02:03:04:05"
        end
        str_array.each do |str|
          byte = str.to_i 16
          if byte < 0 or byte > 255
            raise RangeError, "each element of the address must be between 0x00 and 0xFF"
          end
          new_address << byte
        end
        @address = new_address
      end

      # Returns the string representation of a mac address
      # like "01:00:5E:7F:FF:FA"
      def to_s
        str_array = @address.map {|b| b.to_s(16).rjust(2, "0")}
        str_array.join(":").upcase!
      end
    end
  end
end
