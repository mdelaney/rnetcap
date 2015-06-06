
module Protocol
  module IP
    class Packet
      attr_accessor :version, :header_length, :type_of_service, :total_length,
                    :identification, :flags, :fragment_offset, :ttl, :protocol,
                    :header_checksum, :source_address, :destination_address,
                    :ip_option, :data
    
      def self.decode(data)
        packet = Packet.new()
        packet.version = data[0] >> 4
        packet.header_length = data[0] & 0xFF
        packet.type_of_service = data[1]
        packet.total_length = data[2 ... 4]
        packet.identification = data[4 ... 6]
        packet.flags = data[6] >> 5
        packet.fragment_offset = [data[6] & 0x1F, data[7]]
        packet.ttl = data[8]
        packet.protocol = data[9]
        packet.header_checksum = data[10 ... 12]
        packet.source_address = data[12 ... 16]
        packet.destination_address = data[16 ... 20]
        packet.ip_option = data[20 ... 20 + packet.header_length * 4]
        # TODO: get data
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
