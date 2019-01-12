
-- IFTTT server for ESP8266 -- Receive commands from webhooks and integrate you project to any IFTTT service or device. 
-- Jan 2019 Created by Nikos Georgousis

cmdString="webhooks" --This is an identifier, it acts as a simple filter/"prehistoric password" to avoid attacks
gpio.mode(4, gpio.OUTPUT) --Initialize output

function decide(what) --Here we decide for the commands (this fucntion is called from web server)
	print("Got "..what)
	if what =="on" or what =="enable" or what =="turnon"  then --We expect one of three different keywords (spaced are removed)
		gpio.write(4,1); 
		print ("output on")
		-- Something to turn on 
	elseif what =="off" or what =="disable" or what =="turnoff"  then --We expect one of three different keywords
		gpio.write(4,1); 
		print ("Output off")
		-- Something to turn off 
	elseif what =="test" then
		gpio.write(4,1); 
				print ("Output test")
			tmr.alarm(0, 750, 0, function()  gpio.write(4,0); end) --Just turn the output on for 750 milliseconds
		-- Something to test
	else
				print ("No matching command")
		-- You can add as many commands you like
	end 
end

server = net.createServer(net.TCP) --Create TCP server
function receiver(sck, data) --Process callback on recive data from client
	if data ~=nil then
		substr=string.sub(data,string.find(data,"GET /")+5,string.find(data,"HTTP/")-1) --Filter out on the part needed fro our application
		if substr ~= nil then
			if string.find(substr,'favicon.ico') then --Acting as filter
				--print("This is the favicon return! don't use it "..substr)
			else
				substr=string.lower(substr) --Set the string lower case to check it against
				if string.find(substr,cmdString) then
					if substr~=nil then
						substr=string.sub(substr,string.find(substr,":")+1,string.find(substr,":")+20) --Keep only the text part after the colon
						substr=string.gsub(substr," ","",5)  --Replace all (5) spaces  		
						decide(substr)
					end
				end 
			end 
		end
	end 
   sck:send("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n".."Detected: "..substr) --This is a simple web page response to be able to test it from any web browser 
   sck:on("sent", function(conn) conn:close() end)
end

if server then
  server:listen(8077, function(conn) --Listen to the port 8077
  conn:on("receive", receiver)
  end)
end
	
print ("Statup complete")