#!usr/bin/env ruby
#core

puts "T_Os@ Booting..."; sleep(1)
puts "T_Os booted at #{Time.new}.\nChecking TOsLo...\n"; sleep(0.7)

$PWD = File.dirname(__FILE__)
Dir.chdir($PWD)
toslo = $PWD + '/etc/TOsLo.rb'

##----------------------------- TOsLo -----------------------------

begin
	require_relative toslo
rescue LoadError
	puts "'#{toslo}' not found!\nCannot perform auto load in necessary files."
	puts "Defining temporary function 'load' ..."; sleep(1);
"___________________________________________________

  load PROC opt:DWORD, var:DWORD, back:DWORD
    mov eax,opt
    cmp eax,var
    jne skip
    pop eax
    push jmpAddress
    skip:
    ret
  load ENDP

  push OFFSET back
  mov eax, '.'
  push eax
  push eax
  call load
_____________________________________________________\n".each_char { |c| print c; sleep(0.01); }

	sleep(3)

	loop do
		print "> ";	l = gets.chomp;
		if(l[0..3].downcase == 'load') && (File.exist?(l[5..-1].to_s))
			toslo = l[5..-1]
			break
		elsif (["abort","halt","exit", "quit","cancel"].include?(l.downcase))
			send(:abort)
		else
			puts "\nCannot detect file or inapproriate file !!"
		end
	end
	retry
end

##----------------------------- TOsLo -----------------------------
puts "T_Os@ Logging in..."; sleep(0.4)
3.times {|i| puts "T_Os@ Logging failed (#{i+1}). Retrying..."; sleep(1)}; sleep(0.6)

puts <<-LOGINFAILED
 Auto logging in failed.
 Logged in as 'guest', terminal enabled.
 Please consult the manpage for more information, or type 'help'"
LOGINFAILED

sleep(1)
puts ""
loop do
	print "guest@#{Dir.pwd[2..-1]}> "
	command = gets.chomp
	interpret(command)
end