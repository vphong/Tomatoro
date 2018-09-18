//
//  TomatoroTests.swift
//  TomatoroTests
//
//  Created by Vanna Phong on 06/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import XCTest
import Lottie
@testable import Tomatoro

class TomatoroTests: XCTestCase {
    
    var pomodoroUnderTest: Pomodoro!
    
    let millisecond = 0.1
    let second = 1.0
    let testAccuracy = 0.00001
    
    
    override func setUp() {
        super.setUp()
        pomodoroUnderTest = Pomodoro()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        pomodoroUnderTest = nil
    }
    
    func testPomodoroStarts() {
        let startTime = Date().timeIntervalSinceReferenceDate
        
        pomodoroUnderTest.start()
        
        XCTAssertEqual(startTime, pomodoroUnderTest.startTimestamp, accuracy: testAccuracy)
        XCTAssertEqual(0, pomodoroUnderTest.elapsedTime)
        XCTAssertEqual(pomodoroUnderTest.duration, pomodoroUnderTest.timeLeft)
        // started, but not being run by a Timer
        XCTAssertFalse(pomodoroUnderTest.isRunning)
        
    }
    
    func testPomodoroPauses() {
        
        pomodoroUnderTest.start()
        let startTime = Date().timeIntervalSinceReferenceDate
        
        pomodoroUnderTest.pause()
        
        let pauseTime = Date().timeIntervalSinceReferenceDate
        
        let totalTestTime = pauseTime - startTime
        
        XCTAssertEqual(totalTestTime, pomodoroUnderTest.elapsedTime, accuracy: 1)
        XCTAssertEqual(startTime, pomodoroUnderTest.startTimestamp, accuracy: testAccuracy)
        XCTAssertEqual(pomodoroUnderTest.duration - totalTestTime, pomodoroUnderTest.timeLeft, accuracy: 1)
        XCTAssertFalse(pomodoroUnderTest.isRunning)
        
    }
    
    func testPomodoroRunsAndPauses() {
        pomodoroUnderTest.reset()
        
        pomodoroUnderTest.start()
        let startTime = Date().timeIntervalSinceReferenceDate
        
        Timer.scheduledTimer(withTimeInterval: pomodoroUnderTest.interval, repeats: false) { (timer) in
            
            self.pomodoroUnderTest.pause()
            let pauseTime = Date().timeIntervalSinceReferenceDate
            
            XCTAssertEqual((startTime - pauseTime), self.pomodoroUnderTest.elapsedTime, accuracy: self.testAccuracy)
            XCTAssertEqual(self.pomodoroUnderTest.interval, self.pomodoroUnderTest.elapsedTime, accuracy: self.testAccuracy)
            XCTAssertEqual(self.pomodoroUnderTest.duration - startTime - pauseTime, self.pomodoroUnderTest.timeLeft, accuracy: self.testAccuracy)
        }
    }
    
    func testPomodoroRunsPausesAndResumes() {
        pomodoroUnderTest.reset()
        
        pomodoroUnderTest.start()
        let startTime = Date().timeIntervalSinceReferenceDate
        
        pomodoroUnderTest.pause()
        Timer.scheduledTimer(withTimeInterval: pomodoroUnderTest.interval, repeats: false, block: { (timer) in
            
            let resumeTime = Date().timeIntervalSinceReferenceDate
            self.pomodoroUnderTest.start()
            let testElapsedTime = resumeTime - startTime
            
            // check start time
            XCTAssertEqual(Date().timeIntervalSinceReferenceDate, self.pomodoroUnderTest.startTimestamp, accuracy: self.testAccuracy)
            // check time interval
            XCTAssertEqual(testElapsedTime, self.pomodoroUnderTest.elapsedTime, accuracy: self.testAccuracy)
            XCTAssertEqual(self.pomodoroUnderTest.interval, self.pomodoroUnderTest.elapsedTime, accuracy: self.testAccuracy)
            XCTAssertEqual(self.pomodoroUnderTest.duration - testElapsedTime, self.pomodoroUnderTest.timeLeft, accuracy: self.testAccuracy)
        })
        
        
    }
    
    func testPomodoroResets() {
        
        pomodoroUnderTest.start()
        
        pomodoroUnderTest.reset()
        
        XCTAssertEqual(0, pomodoroUnderTest.startTimestamp)
        XCTAssertEqual(0, pomodoroUnderTest.elapsedTime)
        XCTAssertEqual(pomodoroUnderTest.duration, pomodoroUnderTest.timeLeft)
        XCTAssertNil(pomodoroUnderTest.runner)
    }
    
    
}
