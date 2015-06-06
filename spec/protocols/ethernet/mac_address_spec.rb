require 'spec_helper'
require './protocols/ethernet/mac_address'

include Protocol::Ethernet2

describe Protocol::Ethernet2::MacAddress do
  it "is able to instantiate with a valid string" do
    address_string = "01:00:5E:7F:FF:FA"
    address = MacAddress.new address_string
    expect(address).not_to be_nil
    expect(address.to_s).to eq(address_string)
  end

  it "is able to instantiate with a valid byte array" do
    address_array = [0x01, 0x00, 0x5E, 0x7F, 0xFF, 0xFA]
    address_string = "01:00:5E:7F:FF:FA"
    address = MacAddress.new address_array
    expect(address).not_to be_nil
    expect(address.to_s).to eq(address_string)
  end

  it "raises an argument error if an invalid string is given to parse" do
    address = "foobar"
    expect {MacAddress.new address}.to raise_error(ArgumentError)
  end

  it "raises a range error if a string with any values greater than 0xFF is given" do
    address = "1000:00:00:00:00:00"
    expect {MacAddress.new address}.to raise_error(RangeError)
  end
  
  it "raises an argument error if a string with less than 6 elements is given" do
    address = "00:01:02:03:04"
    expect {MacAddress.new address}.to raise_error(ArgumentError)
  end

  it "raises an argument error if a string with more than elements is given" do
    address = "00:01:02:03:04:05:06"
    expect {MacAddress.new address}.to raise_error(ArgumentError)
  end

  it "raises an index error if an iterable less than 6 elements long is given" do
    address = [0x00, 0x01, 0x02, 0x03, 0x04]
    expect {MacAddress.new address}.to raise_error(IndexError)
  end

  it "raises an index error if an iterable more than 6 elements long is given" do
    address = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06]
    expect {MacAddress.new address}.to raise_error(IndexError)
  end

  it "raises an argument error if an iterable with an element that is not an Integer is given" do
    address = [0x00, 0x01, 0x02, 0x03, 0x04, "foo"]
    expect {MacAddress.new address}.to raise_error(ArgumentError)
  end

  it "raises a range error if an iterable with an element that has a negative value is given" do
    address = [0x00, 0x01, 0x02, 0x03, 0x04, -5]
    expect {MacAddress.new address}.to raise_error(RangeError)
  end

  it "raises an error if an iterable with an element that is greater than 8 bits (255) is given" do
    address = [0x00, 0x01, 0x02, 0x03, 0x04, 256]
    expect {MacAddress.new address}.to raise_error(RangeError)
  end
end

