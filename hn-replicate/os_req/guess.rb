#!usr/bin/env ruby

#guessing

def q_cache
	loop do
		puts "Cache tries for assistance ? (y/n)"; inp = gets.chom
		if inp == 'y'
			$ASSIST = true
		end
		break if (inp == 'y')||(inp == 'n')
	end
end

def commit(guess)
	require 'base64'
	pw = Base64.decode64($PASSWORD)
	likeliness = 0

	pw.length.times {|i|
		likeliness += 1 if pw[i] == guess[i]
	}
	#CACHE == TRUE then
	# => 
	return puts "Likeliness> #{likeliness}"
end


puts "'guess.prtcl' initiated."
$TRIES = 6

loop do
	puts "You have #{$TRIES-=1} tries.";
	break if $TRIES == 0
	try = gets.chomp
	commit(try)
end
