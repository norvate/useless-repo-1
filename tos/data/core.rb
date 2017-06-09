#!usr/bin/env ruby

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

	raise NoMethodError unless $METHOD[tmp[0].to_sym]
	print send(tmp[0].to_sym, *tmp[1..-1])

rescue ArgumentError => e
	puts "Given arguments are not suitable for command."
	puts e.message
	return
rescue NoMethodError
	puts "Command '#{tmp[0]}' not found!"
	return
end

def ls(path = '.', opt='all')
	condition = Hash.new(false)
	fd = 0
	fl = 0

	case opt
	when 'folder', 'file'
		condition[opt] = true
	else
		condition['folder'] = true
		condition['file'] = true
	end

	Dir.chdir(path)

	Dir.entries('.').each { |f|	
		if condition['folder'] && File.directory?(f)
			puts " /#{f}/"
			fd += 1
		end
		if condition['file'] && File.file?(f)
			puts " <#{f}>"
			fl += 1
		end
	}

	Dir.chdir($PWD)

	msg = 'Total '
	msg << "#{fd-2} folder(s)" if condition['folder']
	msg << ", " if condition['folder'] && condition['file']
	msg << "#{fl} file(s)" if condition['file']
	msg << ".\n\n"
rescue 
	puts "'#{path}' doesn't seem to exists."
end

def cd(path='.')
	Dir.chdir(path)
	$PWD = Dir.pwd
	return "=> '#{$PWD}'\n"
rescue
	puts "Path not found! pwd stays unchange."
end

def rm(file)
	return "File '#{File.expand_path(file)[2..-1]}' doesn't exist.\n" unless File.exist?(file)
	File.rename( File.absolute_path(file), $PWD + '/trashbin/' + file )
	nil
rescue
	puts "File #{file} cannot be delete.\n"
end

def cat(f)
	return nil unless File.exist?(f)
	return nil unless File.readable?(f)

	file = File.new(f)
	$ACTIVE = File.expand_path(file.path)

	content = file.read
	puts content
	"\nTOs@ Flagged --$ACTIVE--> '#{f}'.\n"
end

def replace(st1, st2, occurrence = 1)
	return "No active file! Flag file as Active for editting with 'cat' command.\n" if $ACTIVE.empty?
	return "Active file no longer exist! Re-flag file with 'cat' command.\n" unless File.exist?($ACTIVE)

	puts "Assuming target is '#{$ACTIVE}' because it was flagged as Active.\n"

	content = File.new($ACTIVE,'r').read
	matching = -1

	occurrence.times do 
		matching = content[(matching+=1)..-1].index(st1) 
	end

	content[matching...(matching + st1.length)] = st2

	File.new($ACTIVE,'w+').syswrite(content)
	nil
rescue NoMethodError
	puts "Occurrence #{occurrence} for '#{st1}' not found.\nChange was not made.\n"
end

def cls
	system 'cls'; nil
end

def help(cmd = true)
	print "\n"
	require_relative $PWD + '/data/help.rb'
	if (cmd == true) or ($HELP[cmd.to_sym].nil?)
		i = 0
		$HELP.each {|c, d|
			print " ",i+=1,"." ,c.to_s
			puts d
			puts "...press 'Enter' to keep reading"; gets
		}
	else
		print cmd
		puts $HELP[cmd.to_sym]
	end
	nil
rescue LoadError => e
	puts "Help file not found!"
	e.message
end

def immerse(color = 'white')
	cl = Hash.new('7')
	cl = {  :white => '7', 
			:green => 'A', :ice => 'B', :red => 'C', 
			:violet => 'D', :yellow => 'E', :bright => 'F'  }

	system 'color ' + cl[color.to_sym]
	nil
rescue TypeError
	system 'color 7'
	nil
end

[:ls, :cd, :rm, :cat, :replace, :exit, :cls, :help, :immerse].each { |cmd| $METHOD[cmd] = true }