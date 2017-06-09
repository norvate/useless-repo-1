#!usr/bin/env ruby

puts "TOsLo loaded."; sleep(0.2)
puts "TOsLo@ Initialize..."; sleep(0.5)

$BREECH = true
$METHOD = {}

puts "TOsLo@ Loading files..."; sleep(0.5)

["secure.rb", "core.rb"].each { |fname|
	begin
		path_for_f = $PWD + "/data/#{fname}"

		require_relative path_for_f
		puts "TOsLo@ Loaded '#{fname}' successfully."
	rescue LoadError
		puts "Cannot find '#{path_for_f}'"
		puts "You'll have to load it in manually."
	ensure
		sleep(0.3)
	end
}

def load_tools(path)
	require_relative $PWD + path
rescue LoadError => e
	puts e.message
end

cfg = File.new($PWD + '/etc/conf.ig').read

cfg[0].delete(" ")

if cfg[0] == 'load_tools=true'
	cfg[1..-1].each { |cfgline|
		load_tools(cfgline)
	}
end

puts "Closing TOsLo...\n"; sleep(0.5)