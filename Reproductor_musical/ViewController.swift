//
//  ViewController.swift
//  Reproductor_musical
//
//  Created by Rodrigo Velazquez on 06/09/16.
//  Copyright © 2016 Rodrigo Velazquez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    var reproductor: AVAudioPlayer!
    let songName = [["madness","madness"],["american idiot","american"],["the phoenix","phoenix"],["tron: legacy","tron"]]
    var madness:NSURL?
    var american:NSURL?
    var phoenix:NSURL?
    var tron:NSURL?

    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepper.value = 5
        volumeLabel.text = "5"
        stepper.wraps = false
        stepper.autorepeat = true
        
        self.coverImage.image = UIImage(named: "madness")
        madness = NSBundle.mainBundle().URLForResource("madness", withExtension: "mp3")
        american = NSBundle.mainBundle().URLForResource("american", withExtension: "mp3")
        phoenix = NSBundle.mainBundle().URLForResource("phoenix", withExtension: "mp3")
        tron = NSBundle.mainBundle().URLForResource("tron", withExtension: "mp3")
        
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: madness!)
            reproductor.volume = 0.5
        }
        catch{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.songName.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.songName[row][0]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(row == 0){
            self.coverImage.image = UIImage(named: "madness")
            do{
                try reproductor = AVAudioPlayer(contentsOfURL: madness!)
                reproductor.play()
            }
            catch{
                
            }
            
        }
        else if(row == 1){
            self.coverImage.image = UIImage(named: "american")
            do{
                try reproductor = AVAudioPlayer(contentsOfURL: american!)
                reproductor.play()
            }
            catch{
                
            }
        }
        else if(row == 2){
            self.coverImage.image = UIImage(named: "phoenix")
            do{
                try reproductor = AVAudioPlayer(contentsOfURL: phoenix!)
                reproductor.play()
            }
            catch{
                
            }
            
        }
        else if(row == 3){
            self.coverImage.image = UIImage(named: "tron")
            do{
                try reproductor = AVAudioPlayer(contentsOfURL: tron!)
                reproductor.play()
            }
            catch{
                
            }
        }
        
    }
    
    @IBAction func random(sender: AnyObject) {
        
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: getSong())
            reproductor.play()
        }
        catch{
            
        }
    }
    
    @IBAction func play(sender: AnyObject) {
        if(!reproductor.playing){
            reproductor.play()
        }
    }

    @IBAction func pause(sender: AnyObject) {
        if reproductor.playing{
            reproductor.pause()
        }
    }
    @IBAction func stop(sender: AnyObject) {
        if reproductor.playing{
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    func getSong() -> NSURL {
        let posicion = Int(arc4random()) % songName.count
        
        var l = madness!
        
        if(posicion == 0){
            l = madness!
        }
        else if(posicion == 1){
            l = american!
        }
        else if(posicion == 2){
            l = phoenix!
        }
        else if(posicion == 3){
            l = tron!
        }
        
        self.coverImage.image = UIImage(named: self.songName[posicion][1])
        
        return l
    }

    @IBAction func volumeChange(sender: UIStepper) {
        
        print(sender.value)
    }
    
    
    @IBAction func valueChanged(sender: UIStepper) {
        
        print(Int(sender.value).description)
        volumeLabel.text = Int(sender.value).description
        reproductor.volume = Float(sender.value) / 10
    }
    
}

