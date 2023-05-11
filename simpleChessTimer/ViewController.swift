//
//  ViewController.swift
//  simpleChessTimer
//
//  Created by Jacob Davis on 3/9/23.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var player1 = AVAudioPlayer()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sampleView: UIView!
    var words = ["Game Over","Done","Finished","Times up!","All done"]
    
    @IBOutlet weak var p1: UILabel!
    @IBOutlet weak var p2: UILabel!
    var goodTimer: Timer? = nil

    @IBOutlet weak var imageView: UIImageView!
    var counter1 = 600
    var counter2 = 600
    
    var conditionalLogic = 0
    var playerOneTurn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleView.frame = CGRect(origin:  CGPoint(x: 400, y: -200), size: CGSize(width: 240, height: 128))
        p1.text = ""
        p2.text = ""
        // Do any additional setup after loading the view.
    }
    func secondsToMinutesSeconds(_ seconds: Int) -> (String) {
        return "\(seconds / 60):\(seconds % 3600 % 60)"
    }
    
    func playButtonSound(songName: String)  {
        //Customize the name "halo", an of type "mp3" for each file
        let path = Bundle.main.path(forResource: songName, ofType: "wav")!
        
        let url = URL (fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("There is issue with the audio")
        }
    }
    func playAlarmSound(songName: String)  {
        //Customize the name "halo", an of type "mp3" for each file
        let path = Bundle.main.path(forResource: songName, ofType: "wav")!
        
        let url = URL (fileURLWithPath: path)
        
        do {
            player1 = try AVAudioPlayer(contentsOf: url)
            player1.play()
        } catch {
            print("There is issue with the audio")
        }
    }
    
    @IBAction func resetPlayerTwo(_ sender: UIButton) {
        counter2 = 600
        
    }
    @IBAction func resetPlayerOne(_ sender: UIButton) {
        counter1 = 600
    }
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        playButtonSound(songName: "buttonClicked")
        goodTimer?.invalidate()
       goodTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(steve), userInfo: nil, repeats: true)
        if conditionalLogic == 0 {
            conditionalLogic += 1
        } else {
            conditionalLogic -= 1
        }
        goodTimer
       

//        Timer.invalidate(Timer)
    }
    @objc func steve(){
        if counter1 == 595 || counter2 == 595{
            playAlarmSound(songName: "alarmClock")
            goodTimer?.invalidate()
            label.text = "\(words.randomElement()!)"
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = CGPoint(x: 400, y: -200)
            animation.toValue = CGPoint(x: 400, y: view.center.y)
            animation.duration = 0.5
            animation.beginTime = CACurrentMediaTime() + 0.3
    //        animation.repeatCount = 3
            animation.autoreverses = true
            sampleView.layer.add(animation, forKey: nil)
        }
        if conditionalLogic == 0{
            counter1 -= 1
            let couner1Display = secondsToMinutesSeconds(counter1)
            p1.text = "\(couner1Display)"
            p2.text = ""
            imageView.image = UIImage(named: "timerTemplateLeftOn")
        } else {
            let counter2Display = secondsToMinutesSeconds(counter2)
            counter2 -= 1
            p2.text = "\(counter2Display)"
            p1.text = ""
            imageView.image = UIImage(named: "timerTemplateRightOn")
        }
    }
    
}

