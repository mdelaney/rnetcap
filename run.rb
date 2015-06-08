require 'pcaprub'

require './utils'
require './protocols/ethernet/ethernet_2'

capture = PCAPRUB::Pcap.open_live('en1', 65535, true, 0)
capture.setfilter('ip')

while true
  pkt = capture.next
  if pkt
    puts "START"
    bytes = pkt.bytes
    puts(capture.stats)
    puts "raw packet start---------"
    dump_hex(bytes)
    puts "raw packet end-----------"

    # decode EthernetII frame
    ethernet_frame = Protocol::Ethernet2::Frame.decode pkt
    puts ethernet_frame.to_s
    pkt = ethernet_frame.data
    
    # decode IP
    

    pos = 0
    while pos < pkt.length
      
      break
    end
    puts "END"
  end
end


# 192.168.1.4   C0 A8 01 04
# 70.74.19.214  46 4A 13 D6
# ether c8:bc:c8:e7:fa:29

