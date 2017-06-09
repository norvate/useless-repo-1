#!usr/bin/env ruby

$HELP = {
:interpret => "
 'interpret' is used internally and should not be invoke at all.
 By default, everything you type to the console will be pass through 
 'interpret' then tos will follow further instruction that is predefined",
:ls	=> "
 Syntax< ls /PATH/ [OPTION]
 'ls' is short for 'list'.
 Use to list files and folders in the /PATH/ directory.
 You'll have to enter /PATH/ first if want to add [OPTION]
 /PATH/
 	'.' --Current dir by default
 [OPTION] 
	file  --Display file only
	folder --Display folders only
  other option will display files and folders (Default)",
:cd => "
 Syntax< cd /PATH/
 'cd' is short for 'changedir'.
 Use to change current directory.
 'cd' does not support change dir across partition.",
:cat => "
 Syntax< cat /FILEPATH/
 'cat' is short for.. neko..?
	is derived from Unix concatenate function.
 Use to display /FILEPATH/ 's content. Also flagged file as $ACTIVE
 to editting.",
:replace => "
 Syntax< replace 'STRING1' 'STRING2' (NUMBER)
 'replace' is short for... who knows.
 Use to replace occurence (NUMBER) of 'STRING1' in $ACTIVE 
 (see command 'cat') with 'STRING2'.
 <Example>
 >cat txt.txt
	aaa aaa aaa b
	TOs@ Flagged 'txt.txt' as $ACTIVE
 >replace aaa bbb 2
	aaa bbb aaa b",
:cls => "
 Use to clear console screen",
:exit => "
Exit",
:help => "
 Syntax< help :COMMAND:
 Use to display help for :COMMAND: or for every :COMMAND: (default)",
:login =>"
 Perform login. 
 tos will search for users list then auto log in base on session time.
 tos will ask for password if it was needed.",
:guess =>"
 Syntax< guess 'STRING'
 Use to guess words, maybe it's for an upcomming game?",
:immerse => "
 Syntax< immerse 'COLOR'
 Change text color to 'COLOR'.
 [OPTION] 'COLOR' is a string. 
	white(default)
	bright (strong white)
	ice (lightblue)
	blue 
	green,
	yellow,
	red,
	violet "
}

