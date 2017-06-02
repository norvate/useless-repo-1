#!usr/bin/env ruby

def ls(opt='all')
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

	Dir.entries('.').each { |f|	
		if condition['folder'] && File.directory?(f)
			puts "[#{f}]"
			fd += 1
		end
		if condition['file'] && File.file?(f)
			puts "<#{f}>"
			fl += 1
		end
	}
	msg = 'Total '
	msg << "#{fd-2} folder(s)" if condition['folder']
	msg << ", " if condition['folder'] && condition['file']
	msg << "#{fl} file(s)" if condition['file']
	msg << '.'
end

def cd(path='.')
	Dir.chdir(path)
	true
rescue ArgumentError
	puts "Path not found! pwd stays unchange."
	false
end

def rm
end

def cat(f)
	return nil unless File.exist?(f)
	return nil unless File.readable?(f)

	file = File.new(f)
	$ACTIVE = File.expand_path(file.path)

	content = file.read
	puts content
	"Flagged --$ACTIVE--> '#{f}'."
end

def replace(st1, st2, occurrence = 1)
	return "No active file! Flag file as Active for editting with 'cat' command." if $ACTIVE.empty?
	return "Active file no longer exist! Re-flag file with 'cat' command." unless File.exist?($ACTIVE)

	puts "Assuming target is '#{$ACTIVE}' because it was flagged as Active."

	content = File.new($ACTIVE,'r').read
	matching = -1

	occurrence.times do 
		matching = content[(matching+=1)..-1].index(st1) 
	end

	content[matching..(matching + st1.length)] = st2

	File.new($ACTIVE,'w+').syswrite(content)
rescue NoMethodError
	puts "Occurrence #{occurrence} for '#{st1}' not found.\nChange was not made."
end
