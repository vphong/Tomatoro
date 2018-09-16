//
//  Pomodoro.swift
//  Tomatoro
//
//  Created by Vanna Phong on 06/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import Foundation

// A traditional Pomodoro timer. Keeps track of Timer()-related timestamps.
struct Pomodoro {
    
    // MARK: - Properties
    public weak var runner: Timer?
    public let interval = 1.0
    
    public var duration: Double = 60*0.1 {
        didSet {
            timeLeft = max(self.duration - self.elapsedTime, 0)
        }
    }
    public var startTimestamp: Double = 0
    public var elapsedTime: Double = 0 {
        didSet {
            timeLeft = max(self.duration - self.elapsedTime, 0)
        }
    }
    public lazy var timeLeft: Double = {
        return max(self.duration - self.elapsedTime, 0)
    }()

    public var isRunning: Bool {
        return runner != nil
    }
    
    
    
    // MARK: - Functions
    public mutating func setLength(to newLength: Double) {
        duration = newLength
    }
    
    public mutating func start() {
        startTimestamp = Date().timeIntervalSinceReferenceDate - elapsedTime
    }
    
    public mutating func updateElapsedTime() {
        elapsedTime = Double(Int(Date().timeIntervalSinceReferenceDate - startTimestamp))
    }
    
    public mutating func pause() {
        updateElapsedTime()
        stopRunner()
    }
    
    public mutating func reset() {
        startTimestamp = 0
        elapsedTime = 0
        stopRunner()
    }
    
    fileprivate mutating func stopRunner()  {
        runner?.invalidate()
        runner = nil
    }
    
}

// MARK: Errors
enum PomodoroError : Error {
    case negativeTimeLeft
}

// MARK: - Helper extension to format elapsed time
extension Double {
    func elapsedTimeToString() -> String {
        let minutes = Int(self / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
