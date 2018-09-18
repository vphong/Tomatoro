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

@IBDesignable class TimerViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    @IBOutlet weak var progressView: ProgressView!
    @IBInspectable let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var settingsControl: LOTAnimatedSwitch!
    
    var pomodoro = Pomodoro()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        resetButton.isEnabled = false
        timeLabel.text = pomodoro.duration.elapsedTimeToString()
        
        settingsControl.animationView.setAnimation(named: "settings")
        settingsControl.animationView.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        settingsControl.animationView.contentMode = .scaleAspectFill
        settingsControl.animationView.backgroundColor = .clear
        settingsControl.backgroundColor = .clear
        
        
        // styling
        gradientLayer.colors = [UIColor(red: 1.00, green: 0.88, blue: 0.25, alpha:1.0).cgColor, UIColor(red: 0.98, green: 0.44, blue: 0.60, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        gradientLayer.zPosition = -10
        
        self.view.layer.addSublayer(gradientLayer)
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
            print("init: \(pomodoro.elapsedTime)")
            pomodoro.runner = Timer.scheduledTimer(withTimeInterval: pomodoro.interval, repeats: true, block: { (timer) in
                self.pomodoro.updateElapsedTime()
                print("\(self.pomodoro.elapsedTime)")
                self.updateTimeLabel()
            })
            if pomodoro.timeLeft <= 0 {
                
            }
            
            pomodoro.start()
            
            progressView.setDuration(duration: Double(pomodoro.duration))
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
