//
//  TimerViewController.swift
//  Tomatoro
//
//  Created by Vanna Phong on 06/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import UIKit
import Lottie
//import SRCountdownTimer

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    @IBOutlet weak var progressView: ProgressView!
    
    let settingsView = LOTAnimationView(name: "settings")
    
    @IBOutlet weak var settingsControl: LOTAnimatedSwitch!
    
    var pomodoro = Pomodoro()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        resetButton.isEnabled = false
        timeLabel.text = pomodoro.duration.elapsedTimeToString()
        
        settingsControl.animationView.setAnimation(named: "settings")
        settingsControl.animationView.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        settingsControl.animationView.contentMode = .scaleAspectFill
        settingsControl.animationView.backgroundColor = .clear
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Timer UI
    
    @IBAction func startButtonTapped(_ sender: Any) {
        resetButton.isEnabled = true
        
        if pomodoro.isRunning {
            // pause
            pomodoro.pause()
            progressView.pause()
            startButton.setTitle("Resume", for: .normal)
        } else {
            // play
            pomodoro.runner = Timer.scheduledTimer(withTimeInterval: pomodoro.interval, repeats: true, block: { (timer) in
                self.pomodoro.updateElapsedTime()
                self.updateTimeLabel()
            })
            pomodoro.start()
            
            progressView.setDuration(duration: pomodoro.duration)
            progressView.start()
            
            startButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timeLabel.text = pomodoro.duration.elapsedTimeToString()
        startButton.setTitle("Start", for: .normal)
        pomodoro.reset()
        progressView.stop()
        resetButton.isEnabled = false
    }
    
    func updateTimeLabel() {
        
        if pomodoro.timeLeft <= 0 {
            pomodoro.reset()
            // TODO: pomodoro completion UI
            timeLabel.text = "00:00"
            return
        }
        
        if pomodoro.isRunning {
            timeLabel.text = pomodoro.timeLeft.elapsedTimeToString()
        } else {
            timeLabel.text = pomodoro.duration.elapsedTimeToString()
            pomodoro.pause()
        }
    }
    
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        print("hi")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension Double {
    func percentToAngle() -> CGFloat {
        return CGFloat(self*360 - 90)
    }
}
