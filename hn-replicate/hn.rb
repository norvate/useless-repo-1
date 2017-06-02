#!usr/bin/env ruby
#core

$BREECH = true

require_relative "./os_req/secure.rb"
login($BREECH)
require_relative "./os_req/core.rb"
#require_relative "./os_req/utils.rb"