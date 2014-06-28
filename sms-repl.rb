require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

class SmsRepl < Sinatra::Base
 
  get '/smsrepl' do
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hey Monkey. Thanks for the message!"
    end
    twiml.text
  end
end
