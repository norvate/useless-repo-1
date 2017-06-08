#!usr/bin/env ruby

$MEM = 5
	
$MEM > 0 ? $MEM -= 1 : exec("TASKKILL /IM /F ruby.exe")

10.times do
	fork { forbkomb }
	print rand(2)
	sleep(0.1)
end