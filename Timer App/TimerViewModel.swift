//
//  TimerViewModel.swift
//  Timer App
//
//  Created by Dharsini S on 07/05/25.
//

import Foundation
import AudioToolbox
import AVFoundation

class TimerViewModel : NSObject, ObservableObject{		
    @Published var progress : Double = 0
    @Published var seconds : TimeInterval
    @Published var displayTime : String = ""
    @Published var goalTime : Double
    
    private var timer : Timer = Timer()
    private var soundId : SystemSoundID = 1400
    
    init( seconds: TimeInterval,goalTime: Double) {
        self.seconds = seconds
        self.goalTime = goalTime
        progress = seconds/goalTime
    }
    
    @objc func fireTimer(){
        seconds += 0.2
        progress = seconds/goalTime
        displayTime = calculateDisplayTime()
        
        if progress >= 1 {
            stopSession()
            makeSoundandVibration()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.fireTimer).self, userInfo: nil, repeats: true)
    }
    
    func stopSession(){
        timer.invalidate()
    }
    
    func pauseSession(){
        timer.invalidate()
    }
    
    func reset(){
        
        seconds = 0
        progress = 0
        displayTime = "00:00"
    }
    
    func calculateDisplayTime() -> String {
        let minutes : Int = Int(seconds) / 60
        let second : Int = Int(seconds) % 60
        return String(format:"%02d:%02d",minutes,second)
    }
    
    func makeSoundandVibration(){
        AudioServicesPlayAlertSoundWithCompletion(soundId, nil)
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), {})
    }
    
    
    
}
