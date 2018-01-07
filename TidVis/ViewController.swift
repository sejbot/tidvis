//
//  ViewController.swift
//  TidVis
//
//  Created by Tobias Glosboken on 2017-12-30.
//  Copyright © 2017 Bulleriberg. All rights reserved.
//

import UIKit;
import UserNotifications;
import AudioToolbox;
import AVFoundation;

class ViewController: UIViewController, SelectTimeControlDelegate {
    
    //MARK: Properties
    @IBOutlet weak var selectTimeControl: SelectTimeControl!
    @IBOutlet weak var timerLights: TimerLights!
    
    var timer = Timer();
    var isTimerRunning = false;
    var secondsLeft = 0;
    var endDate: Date = Date.init();
    var viewOrder = 0;
    var buttonValues = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTimeControl.delegate = self;
        selectTimeControl.setupButtons(buttonValues);
        if(isTimerRunning) {
            timerLights.selectLightsBasedOnSecondsLeft(seconds: secondsLeft);
        }
    }
    
    //MARK: Public methods
    func didPressButton(button: UIButton) {
        if(!isTimerRunning) {
            timerLights.stopAnimation();
            secondsLeft = Int((button.titleLabel?.text)!)! * 60 - 1;
            timerLights.selectLightsBasedOnSecondsLeft(seconds: secondsLeft);
            setupNotification(secondsLeft: secondsLeft);
            runTimer();
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true);
        isTimerRunning = true;
    }
    
    func playSoundTimeIsUp() {
        //let path = Bundle.main.path(forResource: "analog-watch-alarm_daniel-simion.mp3", ofType:nil)!
        //let url = URL(fileURLWithPath: path)
        let systemSoundId: SystemSoundID = 1304;
        AudioServicesPlaySystemSound(systemSoundId);
        //do {
        //    let alarm = try AVAudioPlayer(contentsOf: url);
        //    alarm.play();
        //}
        //catch {
        //    print("Couldn't load file \(url)");
        //}
    }
    
    @objc func updateTimer() {
        secondsLeft = Calendar.current.dateComponents([.second], from: Date.init(), to: endDate).second ?? 0;
        if(secondsLeft < 0) {
            timer.invalidate();
            isTimerRunning = false;
            timerLights.showTimeIsUp();
            playSoundTimeIsUp();
        }
        else {
            secondsLeft -= 1;
            timerLights.selectLightsBasedOnSecondsLeft(seconds: secondsLeft);
        }
    }
    
    func setupNotification(secondsLeft: Int) {
        print("setting up notification");
        let content = UNMutableNotificationContent();
        content.title = NSString.localizedUserNotificationString(forKey: "Tiden är slut!", arguments: nil);
        content.body = "Upp och hoppa!"
        content.sound = UNNotificationSound.default();
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondsLeft), repeats: false);
        print("Notification will fire at \(trigger.nextTriggerDate())");
        let request = UNNotificationRequest(identifier: "TimerCountdown", content: content, trigger: trigger);
        let center = UNUserNotificationCenter.current();
        center.add(request) { (error: Error?) in
            if let theError = error {
                print(theError.localizedDescription);
            }
        };
        
        endDate = trigger.nextTriggerDate()!;
    }
}

