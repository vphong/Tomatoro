//
//  Pomodoro.swift
//  Tomatoro
//
//  Created by Vanna Phong on 06/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import Foundation

// A traditional Pomodoro timer.
class Pomodoro {
    
    private var startTime: Date?
    public weak var runner: Timer?
    
    public var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    public var elapsedTimeAsString: String {
        let minutes = UInt(elapsedTime / 60)
        let seconds = UInt(elapsedTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = UInt((elapsedTime * 10).truncatingRemainder(dividingBy: 10))
        
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }
    
    public var isRunning: Bool {
        return startTime != nil
    }
    
    // MARK: - Runner functions
    
    init() {
        // todo
    }
    
    public func start() {
        startTime = Date()
    }
    
    public func stop() {
        startTime = nil
    }
    
    
    
}
