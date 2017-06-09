#!usr/bin/env ruby

def breech_detected_init_pass
	require 'base64'

	puts " WARNING!! Security Breech found!"; sleep(1)
	puts " Initialize new PASSWORD for 'root'"; sleep(0.5)
	#3.times{ print '.'; sleep(1)}; print "\n"; 
	40.times{ print '-'; sleep(0.07)}; print "\n"

	puts "INITPw1: #{$INITPASS1 = rand(Time.new.day * Time.new.sec)}"; sleep(1)
	puts "INITPw2: #{$INITPASS2 = rand(Time.new.year * Time.new.min / rand(Time.new.sec)+1)}\n"; sleep(1)

	f = File.new($PWD + "/data/dic.txt")
	arr = IO.readlines(f)

	arr = arr[$INITPASS1 % 13]
	arr.slice!(0..1)

	arr.delete!('"')
	arr.delete!(' ')
	arr.delete!('[]')
	arr = arr.split(",")

	$PASSWORD = Base64.encode64(arr[$INITPASS2 % arr.size])
	$PWLENG = Base64.decode64($PASSWORD).length
end

def login
	puts "Loading users list..."
	print "Found: "; sleep(2); puts "'root';"; sleep(0.3);
	puts "Login as 'root'..."; sleep(0.6);
	40.times { print '-'; sleep(0.005) }; print "\n"

	breech_detected_init_pass if $BREECH

	print "USERNAME<"; sleep(0.3); puts " root"; sleep(0.3)
	puts "PASSWORD< \n"; sleep(0.5)

	puts "Loading guessing protocol..."; sleep(0.7);

	load $PWD + '/tools/guess.rb'
	return
rescue => e
	puts "Load failed: File missing"
	puts e.message
end

[:login].each{ |cmd| $METHOD[cmd] = true }
