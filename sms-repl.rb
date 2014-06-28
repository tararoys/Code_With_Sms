require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

class SmsRepl < Sinatra::Base
 
  get '/smsrepl' do
    twiml = Twilio::TwiML::Response.new do |r|
          answer= eval params[:Body]
      r.Message do |message| 
          message.Body answer.to_s
      end
    end
    twiml.text
  end
end
