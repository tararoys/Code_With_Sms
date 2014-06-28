require File.expand_path('../sms-repl.rb', __FILE__)
use Rack::ShowExceptions
run SmsRepl.new
