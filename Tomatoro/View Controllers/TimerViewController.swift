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
    
    let pomodoro = Pomodoro()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        resetButton.isEnabled = false
        timeLabel.text = pomodoro.length.elapsedTimeToString()
        
        
        settingsControl.animationView.setAnimation(named: "settings")
        settingsControl.animationView.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        settingsControl.animationView.contentMode = .scaleAspectFill
        settingsControl.animationView.backgroundColor = .clear
        
//        settingsView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
//        settingsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        settingsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    // MARK: - Timer UI
    
    @IBAction func startButtonTapped(_ sender: Any) {
        resetButton.isEnabled = true
        
        if pomodoro.isRunning {
            // pause
            pomodoro.pause()
            startButton.setTitle("Start", for: .normal)
        } else {
            // play
            pomodoro.runner = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TimerViewController.updateTimeLabel), userInfo: nil, repeats: true)
            pomodoro.start()
            startButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timeLabel.text = pomodoro.length.elapsedTimeToString()
        startButton.setTitle("Start", for: .normal)
        pomodoro.reset()
        resetButton.isEnabled = false
    }
    
    
    
    @objc func updateTimeLabel() {
        
        let timeLeft = pomodoro.length - (Date().timeIntervalSinceReferenceDate - pomodoro.startTimestamp)
        if pomodoro.isRunning {
            let progress = timeLeft / pomodoro.length
            timeLabel.text = timeLeft.elapsedTimeToString()
        } else {
            timeLabel.text = pomodoro.length.elapsedTimeToString()
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
