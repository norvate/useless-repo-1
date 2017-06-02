#!usr/bin/env ruby

def breech_detected_init_pass
	require 'base64'

	puts "WARNING!! Security Breech found!"; sleep(1)
	puts "Initialize new PASSWORD for 'root'"
	3.times{ print '.'; sleep(1)}; print "\n"; 
	40.times{ print '-'; sleep(0.07)}; print "\n"

	puts "$INITPASS1: #{$INITPASS1 = rand(Time.new.day * Time.new.sec)}"; sleep(1)
	puts "$INITPASS2: #{$INITPASS2 = rand(Time.new.year * Time.new.min / rand(Time.new.sec))+1}"; sleep(1)

	f = File.new("./os_req/dic.txt")
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

def login(brch)
	puts "Loading users list..."
	print "Found: "; sleep(2); puts "'root'"; sleep(0.3);
	puts "Login as 'root'..."; sleep(0.6);
	40.times { print '-'; sleep(0.005) }; print "\n"

	breech_detected_init_pass if brch

	puts "USERNAME< root"
	puts "PASSWORD< "

	Dir.chdir(File.expand_path('.'))

	puts "Loading guessing protocol..."; sleep(0.7);
	require_relative './guess.rb'
rescue
	puts "Load failed: File missing"
end

login(true)
