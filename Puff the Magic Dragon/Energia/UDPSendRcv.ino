  
  /*
    WiFi UDP Send and Receive String
  
   This sketch wait an UDP packet on localPort using the CC3200 launchpad
   When a packet is received an Acknowledge packet is sent to the client on port remotePort
  
  
   created 30 December 2012
   by dlf (Metodo2 srl)
   
   modified 1 July 2014
   by Noah Luskey
   
   CreateNetwork
  Start WiFi in in AP mode creating a network that you can connecto to
  from a PC or SmartPhone. There is a limitation that only ONE device
  can be connected. Trying to connect to the network with a second client 
  will fail. To connect with a different device, first disconnect the device
  currently connected.
  
  Hardware Required:
  * CC3200 LaunchPad or MSP430/TivaC LaunchPad with CC3200 BoosterPack

  Created November 2014
  by Robert Wessels
   
   modified 7 June 2015
   by Mitchell McGinnis
  
   */
  
  #ifndef __CC3200R1M1RGC__
  // Do not include SPI for CC3200 LaunchPad
  #include <SPI.h>
  #endif
  #include <WiFi.h>
  #define DEBUG 1
  // your network name also called SSID
  char ssid[] = "CC3200 Demo";
  // your network password
  char password[] = "password";
  
  unsigned int localPort = 2390;      // local port to listen on
  char mode = 'o';
  
  char packetBuffer[255]; //buffer to hold incoming packet
  char  ReplyBuffer[] = "acknowledged";       // a string to send back
  
  WiFiUDP Udp;
  
  void setup() {
    setupDragon();
    //Initialize serial and wait for port to open:
    Serial.begin(115200);
  
    if(DEBUG){
       // attempt to connect to Wifi network:
      Serial.print("Attempting to connect to Network named: ");
      // print the network name (SSID);
      Serial.println(ssid); 
      // Start WiFi and create a network with wifi_name as the network name
      // with wifi_password as the password.
      Serial.print("Starting network...");
    }
    WiFi.beginNetwork(ssid, password);
    if(DEBUG){
      Serial.println("done.");
      Serial.println("\nDisplaying Wifi Status");
      printWifiStatus();
  
      Serial.println("\nWaiting for a connection from a client...");
    }
    Udp.begin(localPort);
  }
  
  void loop() {
  
    // if there's data available, read a packet
    int packetSize = Udp.parsePacket();
    if (packetSize){
      if(DEBUG){
        Serial.print("Received packet of size ");
        Serial.println(packetSize);
        Serial.print("From ");
        IPAddress remoteIp = Udp.remoteIP();
        Serial.print(remoteIp);
        Serial.print(", port ");
        Serial.println(Udp.remotePort());
    
        // read the packet into packetBufffer
        int len = Udp.read(packetBuffer, 255);
        if (len > 0) packetBuffer[len] = 0;
        Serial.println("Contents:");
        Serial.println(packetBuffer);
    }
      mode = packetBuffer[0];
      // send a reply, to the IP address and port that sent us the packet we received
      Udp.beginPacket(Udp.remoteIP(), localPort+1);
      Udp.write(ReplyBuffer);
      Udp.endPacket();
    }
    loopDragon();
  }
  
  void printWifiStatus() {
    // print your WiFi IP address:
    IPAddress ip = WiFi.localIP();
    Serial.print("IP Address: ");
    Serial.println(ip);
  }
  
  
  

