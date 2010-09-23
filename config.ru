require 'fake_sinatra'

get '/about_chuck' do
  body = "Help Chuck go to RubyConf by clicking this link <a href=\"http://pledgie.com/campaigns/13439\">http://pledgie.com/campaigns/13439</a>"
  [200, {"Content-Type" => "text/html"}, body]
end


app = lambda do |env|
  body = File.open(File.dirname(__FILE__) + "/404.html", "r").read
  [404, {"Content-Type" => "text/html"}, body]
end

run app