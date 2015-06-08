require 'spec_helper'
require './protocols/ethernet/ethernet_2'

include Protocol::Ethernet2

describe Protocol::Ethernet2::Frame do
  # we force the encoding to ASCII-8BIT to ensure we can correctly compare
  # the results that we get back from tests
  frame_data = ("\x45\x00\x00\x34\x4E\x61\x40\x00" +
                "\x40\x06\x2A\x33\xC0\xA8\x01\x04" +
                "\xAD\xC0\x52\xC3\xC9\x19\x00\x50" +
                "\xEE\x0E\xE3\xB8\x9B\xF0\xA1\x56" +
                "\x80\x10\x10\x0E\x8D\x83\x00\x00" +
                "\x01\x01\x08\x0A\x48\xF5\x5D\xCC").force_encoding 'ASCII-8BIT'
  frame_destination_mac = "\x20\xE5\x2A\x11\xCA\x0C".force_encoding 'ASCII-8BIT'
  frame_source_mac = "\xC3\xBC\xC8\xE7\xFA\x29".force_encoding 'ASCII-8BIT'
  frame_type = "\x08\x00".force_encoding 'ASCII-8BIT'
  frame_crc = "\x5F\x2F\x38\x92".force_encoding 'ASCII-8BIT'
  frame = frame_destination_mac + frame_source_mac + frame_type + frame_data + frame_crc

  frame_destination_string = "20:E5:2A:11:CA:0C"
  frame_source_string = "C3:BC:C8:E7:FA:29"
  frame_type_integer = 2048
  frame_crc_integer = 1596930194

  it "we can create a frame from valid data" do
    frame = Frame.decode frame
    expect(frame).not_to be_nil
    expect(frame.destination.to_s).to eq(frame_destination_string)
    expect(frame.source.to_s).to eq(frame_source_string)
    expect(frame.type).to eq(frame_type_integer)
    expect(frame.crc).to eq(frame_crc_integer)
    expect(frame.data).to eq(frame_data)
  end

end
 
