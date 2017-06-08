#!usr/bin/env ruby

fdic = File.new("./dict.txt","r")
fgen = File.new("./dict.e64","w+")

File.truncate(fgen, 0)

words = Array.new(255){Array.new()}

fdic.each_line {|line|
	words[line.chomp.length].push(line.chomp)
}

fdic = File.new("./dic.txt","w+")
fdic.truncate(0)

words.compact!
len = 2

words.each{|i|
	if i.size > 1
		fdic.syswrite("#{len} #{i.to_s}\n")
		len += 1
	end
}