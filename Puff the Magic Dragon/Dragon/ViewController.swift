//
//  ViewController.swift
//  Dragon
//
//  Created by Mitch on 6/3/15.
//  Copyright (c) 2015 Mitch. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

struct Stuff {
    static let puff:String = "puff"
    static let dragon:String = "dragon"
    static let off:String = "off"
    static let IP = "192.168.1.1"
    static let settings:String = "http://\(IP)"
    static let PORT = 2390
    static var count = 0
}

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    let udp = UDP(Stuff.PORT)
    var state = false
    var connected = false
    
    @IBOutlet weak var modeControl: UISegmentedControl!

    @IBAction func chooseAudio(sender: AnyObject) {
        stop()
        let picker = MPMediaPickerController(mediaTypes: MPMediaType.AnyAudio)
        picker.allowsPickingMultipleItems = true
        picker.showsCloudItems = false
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
     }
    
    @IBAction func stop(){
        udp.sendString(Stuff.off)
        MPMusicPlayerController.systemMusicPlayer().stop()
    }
    
    @IBAction func next(){
        MPMusicPlayerController.systemMusicPlayer().skipToNextItem()
    }
    
    @IBAction func openConfig(sender: UIButton) {
        if connected {
            UIApplication.sharedApplication().openURL(NSURL(string: Stuff.settings)!)
        }
        else{
            alert("Error", msg: "Not connected to the CC3200 Demo Board. Please connect to the CC3200 Demo Wifi Network to communicate with the CC3200.")
        }
    }
    
    @IBAction func prev(){
        MPMusicPlayerController.systemMusicPlayer().skipToPreviousItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connected = Reachability.isConnectedToCC3200()
        initAppearance()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if connected {
            alert("Error", msg: "Not connected to the CC3200 Demo Board. Please connect to the CC3200 Demo Wifi Network to communicate with the CC3200.")
        }
    }
    
    func initAppearance() -> Void {
        let background = CAGradientLayer().redToTurq()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        Stuff.count = mediaItemCollection.count
        for item in mediaItemCollection.items {
            let itemName = item.valueForProperty(MPMediaItemPropertyTitle) as? String
            println("Picked item: \(itemName)")
        }
        
        MPMusicPlayerController.systemMusicPlayer().setQueueWithItemCollection(mediaItemCollection)
        if (AVAudioSession.sharedInstance().otherAudioPlaying){
            alert("Warning", msg: "Audio is currently being played. Please stop all audio and try again.")
        }
        else{
            play()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func play(){
            if modeControl.selectedSegmentIndex == 0 {
                udp.sendString(Stuff.dragon)
            }
            else{
                udp.sendString(Stuff.puff)
            }
        MPMusicPlayerController.systemMusicPlayer().play()
        
        //Uncomment to change repeatMode
         MPMusicPlayerController.systemMusicPlayer().repeatMode = MPMusicRepeatMode.None
    }
}

extension CAGradientLayer {
    
    func redToTurq() -> CAGradientLayer {
        let topColor = UIColor(red: (190/255.0), green: (0/255.0), blue: (0/255.0), alpha: 1)
        let bottomColor = UIColor(red: (210/255.0), green: (234/255.0), blue: (238/255.0), alpha: 1)
        
        let gradientColors: Array <AnyObject> = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: Array <AnyObject> = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
}

extension UIViewController {
    func alert(title: String, msg: String){
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        actionSheetController.addAction( UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}

extension String{
    func contains(str: String) -> Bool{
        return self.rangeOfString(str) != nil
    }
}
