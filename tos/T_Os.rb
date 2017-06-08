#!usr/bin/env ruby
#core

puts "T_Os@ Booting..."; sleep(1)
puts "T_Os booted at #{Time.new}. Checking TOsLo...\n"; sleep(0.7)

puts "TOsLo loaded."; sleep(0.2)
puts "TOsLo@ Initialize..."; sleep(0.5)

Dir.chdir(File.dirname(__FILE__))
$BREECH = true
$METHOD = {}

puts "TOsLo@ Loading files..."; sleep(0.5)
puts "TOsLo@ Load 'secure' succeed." if require_relative "./data/secure.rb"; sleep(0.3)
puts "TOsLo@ Load 'core' succeed." if require_relative "./data/core.rb"; sleep(0.3)
puts "Exit TOsLo.\n"; sleep(0.2)
puts "T_Os@ Logging in..."; sleep(0.4)
3.times {|i| puts "T_Os@ Logging failed (#{i+1}). Retrying..."; sleep(1)}; sleep(0.6)
puts "\n Auto logging in failed.\n Logged in as 'guest', terminal enabled.\n Please consult the manpage for more information, or type 'help'"
#require_relative "./os_req/utils.rb"

def interpret(cmd)
	tmp = cmd.split(" ")
	tmp.push("\"\"")

	len = tmp.length
	l = r = 0

	loop do
		(l...len).step {|i|
			if tmp[i][0] == "\""
				l = i; break
			end
		}
		r = l
		(r...len).step {|i|
			if tmp[i][-1] == "\""
				r = i; break
			end
		}

		break if (l == len-1)&&(r == len-1)
		
		tmp[l] = tmp[l..r].join(' ')
		tmp[l] = tmp[l][1...-1]
		#tmp[l].delete_at!(0) if tmp[l][0] == "\""
		#tmp[l].delete_at!(-1) if tmp [l][-1] == "\""
		#tmp[l].delete!("\"")

		((l+1)..r).step {|i| tmp[i].clear}
		l = r + 1
	end

	tmp.delete("")
	tmp.pop

	raise unless $METHOD[tmp[0].to_sym]
	puts send(tmp[0].to_sym, *tmp[1..-1])

rescue ArgumentError => e
	puts "Given arguments are not suitable for command."
	puts e.message
rescue 
	puts "Command '#{tmp[0]}' not found!"
end

sleep(1)
loop do
	print "\nguest@#{Dir.pwd[2..-1]}> "
	command = gets.chomp
	interpret(command)	
end