//
//  TimerViewController.swift
//  Tomatoro
//
//  Created by Vanna Phong on 06/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    let pomodoro = Pomodoro()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Timer UI
    @IBAction func startButtonTapped(_ sender: Any) {
        
        if pomodoro.isRunning {
            // pause
            pomodoro.runner?.invalidate()
        } else {
            // play
            print("Starting stopwatch")
            pomodoro.runner = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TimerViewController.updateTimeLabel), userInfo: nil, repeats: true)
            pomodoro.start()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        print(pomodoro.elapsedTime)
        pomodoro.runner?.invalidate()
        pomodoro.stop()
    }
    
    
    @objc func updateTimeLabel() {
        
        if pomodoro.isRunning {
            timeLabel.text = pomodoro.elapsedTimeAsString
        } else {
            pomodoro.runner?.invalidate()
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
