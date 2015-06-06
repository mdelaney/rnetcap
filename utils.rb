
# print data, 4 bytes per line
# hex, binary, ascii
def dump_hex(data)
  i = 0
  while i < data.length
    bytes_to_read = ((data.length - i) > 4) ? 4 : data.length - i
    bytes = data[i ... i + bytes_to_read]
    i += bytes_to_read
    bytes.each {|b| print b.to_s(16).rjust(2, "0").upcase + " "}
    print "\t"
    bytes.each {|b| print b.to_s(2).rjust(8, "0").upcase + " "}
    print "\t"
    bytes.each {|b| print (b > 32) ? b.chr : '.'}
    puts ""
  end
end
