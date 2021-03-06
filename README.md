# IFTTT to ESP8266

![N|Solid](https://github.com/limbo666/IFTTT_to_ESP8266/blob/master/Other/logo1.jpg?raw=true)

An http server for nodemcu (lua) based ESP8266 projects. 
With this server you can receive commands IFTTT utilizing the webhooks functionality.

#### What's hot?
  - Simple configuration from ESP8266 side.
  - A plain text can be used as filter (you can call it password, while is not) to avoid overload.
  - Immediate response* 

#### How to use
> Change "cmdString" value with keyword of your preference (optional but recommended).

> Set the accepted keywords on the "Decide" function.

> Change server port - default is set to 8077 (optional).

> Upload your lua file to the ESP8266.


##### Testing locally
Ensure that your ESP8266 module has access to the network. In most cases a `print(wifi.sta.getip())` is enough to verify the IP address. Then execute the lua script (dofile). 
Open your web browser and type:
http://`IP_Address`:`Port`/`cmdString`:`Command`
- `IP_Address` = Your ESP8266 WiFi IPv4 adress 
- `Port` = The server port (default is 8077)
- `cmdString` = Your keyword (default is "webhooks")
- `Command` = Your command. e.g. on the default configuration you can use "on", "off", "enable", "turnon", "turnoff", "disable" and "test"
[![N|Solid](https://raw.githubusercontent.com/limbo666/IFTTT_to_ESP8266/master/Other/testing.gif)
If everything is correct your will see a webpage with *"Detected: "* followed by your command (e.g. *Detected: on*).

#### IFTTT setup
On IFTTT side you have create as many applets as you like and set the action to webhooks. 
To connect to your server, you should add the link to the action URL field. 
http://`your_ip_or_ddns`:8077/Webhooks:`Your_Command`
- `your_ip_or_ddns` = Your public IP or your dynamic dns   
- `Your_Command` = The command you want to send (an expected from your ESP module)
[![N|Solid](https://raw.githubusercontent.com/limbo666/IFTTT_to_ESP8266/master/Other/IFTTT_Action.png)

The method should be set as "GET"

##### Limitations
This is an tcp server. NodeMCU firmware has limited resources, thus this server cannot co-exist if another tcp server on your project.

The server works under plain http connection so it is possible to get attacked by sniffing the TCP communication. Be aware that it is not recommended to use it on your nuclear reactor.

*Immediate response is depended on IFTTT webhooks stability and server load. 


[![N|Solid](https://raw.githubusercontent.com/limbo666/IFTTT_to_ESP8266/master/Other/Logo2.png)](https://georgousis.info/#Creations)\
**Hand Water Pump Jan-2019**\
**Created by Nikos Georgousis**
