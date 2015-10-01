# Puff-the-Magic-Demo
The necessary files to start basic communication between a CC3200 board and an iOS device

##Getting Started Energia: 

  http://energia.nu/cc3200guide/
  
  http://energia.nu/guide/ 
  
  http://energia.nu/reference/
  
  http://energia.nu/reference/wifi/
  

•	This was the most help getting started followed second by the build in examples in Energia. They made creating a Wi-Fi network, sending and receiving UDP packets, and other development a simple jump.

•	Following the upgrading firmware, instructions on the guide are VITAL to getting the Wi-Fi modules working. This is the most critical part of setup but once it’s done it never needs to be done again.

##Getting Started Xcode: 
Download from the App Store 
  - https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12#
  
##Great resource for first time App Creation 
***A developer’s license is required to distribute to the App Store.***
  - https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOS/FirstTutorial.html
  
##Using Swift
Use of UDP.swift is the only base requirement to start communicating with the CC3200 in iOS.  Since the CC3200 creates a Wi-Fi network the only way to communicate is by joining its’ Wi-Fi network; called “CC3200 Demo” with password “password”. The IP address of the CC3200 will be 192.168.1.1 and, if unchanged, the port will be 2390. Any device can send a UDP packet to the CC3200 and this iOS app is just one example. 

###CC3200
The CC3200 has three LED modes dragon, puff, and off. To change the mode simple send the word you want to the CC3200. It will send a response that says, “acknowledged”; to ensure the CC3200 got the message. 

###iOS App
In it’s current state the iOS app does not listen for the response and tries to join the CC3200’s configuration page as a test whether it is connected to it or not.

###Android App
Coming soon

