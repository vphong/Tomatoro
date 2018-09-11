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
    
    // MARK: - Properties
    public weak var runner: Timer? // to be set by view controller
    
    public var startTimestamp: Double = 0
    public var elapsedTime: Double = 0

    public var isRunning: Bool {
        return runner != nil
    }
    
    public var length: Double = 60*25
    
    public var progress: Double {
        return elapsedTime / length
    }
    
    // MARK: - Functions
    public func setLength(to newLength: Double) {
        length = newLength
    }
    
    public func start() {
        startTimestamp = Date().timeIntervalSinceReferenceDate - elapsedTime
    }
    
    public func pause() {
        elapsedTime = Date().timeIntervalSinceReferenceDate - startTimestamp
        stopRunner()
    }
    
    public func reset() {
        startTimestamp = 0
        elapsedTime = 0
        stopRunner()
    }
    
    private func stopRunner()  {
        runner?.invalidate()
        runner = nil
    }
    
    
    
}

// MARK: - Helper extension to format elapsed time
extension Double {
    func elapsedTimeToString() -> String {
        let minutes = Int(self / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((self * 10).truncatingRemainder(dividingBy: 10))
        
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }
}
