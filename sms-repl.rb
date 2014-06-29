require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

class SmsRepl < Sinatra::Base

  helpers do
    def place_in_script(phone_number)
       line_number= 0
       if File.file?(phone_number)
        File.open(phone_number) {|f|line_number = f.readline.to_i}
       end
       line_number 
    end
    
    def next_line(line_number, phone_number)
       File.open(phone_number, 'w') {|f| f.write(line_number + 1) }
    end 

  end  
  get '/smsrepl' do
    phone_number = params[:From][1..-1]
    script = IO.readlines("script.rb")
   
    twiml = Twilio::TwiML::Response.new do |r|
         if eval(script[place_in_script(phone_number)]) == "try again"  
           r.Message do |message|
             message.Body "try again"
           end
         else
           r.Message do |message|
             message.Body eval(script[place_in_script(phone_number)]) 
             next_line(place_in_script(phone_number), phone_number)
           end
         end
    end
    twiml.text
  end
end
