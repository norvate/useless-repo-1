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

def guess(g)
		require 'base64'
		pw = Base64.decode64($PASSWORD).downcase
		#puts pw
		likeliness = 0

		$PWLENG.times {|i|
			likeliness += 1 if pw[i] == g[i]
		}
		#CACHE == TRUE then
		# =>
		unless likeliness == $PWLENG
			puts "Likeliness> #{likeliness}"
			puts "You have #{$TRIES-=1} tries."

			if $TRIES == 0
				$METHOD[:guess] = false
				puts "Failed to guess password."
				puts "Deleting all temporary cache."
				puts "Please call 'login' to retry again."
			end
		else 
			sleep(5);
			return "Password correct.\n"
		end
end

$METHOD[:guess] = true
$TRIES = 6

puts "Defining 'guess' function...\n"; sleep(1)
"___________________________________________________

  guess FUNC g:STRING, eql:DWORD, t:DWORD
    hsh g, tmp
    sto tmp, var
    mea tmp, len1
    mea psw, len2
    cmp len1, len2, eql
   	if eql = FAL jumpTo :wrong
    cmp g, psw, eql
    if eql = FAL jumpTo :wrong
    
    pop tmp
    push allow
    jne wrong
    	ret
    	dcr t
    if t = 0 :exit
  guess ENDP

  push OFFSET t
  mov tmp, >
  push tmp
  push eax
  call guess
_____________________________________________________\n\n".each_char { |c| print c; sleep(0.01); }

sleep(3)
puts "You can now call 'guess'"
puts "You have #{$TRIES-=1} tries.";
puts "leng: #{$PWLENG}"

