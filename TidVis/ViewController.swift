//
//  ViewController.swift
//  TidVis
//
//  Created by Tobias Glosboken on 2017-12-30.
//  Copyright © 2017 Bulleriberg. All rights reserved.
//

import UIKit;
import AudioToolbox;

class ViewController: UIViewController, SelectTimeControlDelegate {
    
    //MARK: Properties
    @IBOutlet weak var selectTimeControl: SelectTimeControl!
    @IBOutlet weak var timerLights: TimerLights!
    
    var timer = Timer();
    var isTimerRunning = false;
    var secondsLeft = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTimeControl.delegate = self;
    }
    
    //MARK: Public methods
    func didPressButton(button: UIButton) {
        if(!isTimerRunning) {
            timerLights.stopAnimation();
            secondsLeft = Int((button.titleLabel?.text)!)! * 60;
            timerLights.selectLightsBasedOnSecondsLeft(seconds: secondsLeft);
            runTimer();
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true);
        isTimerRunning = true;
    }
    
    func playSoundTimeIsUp() {
        let systemSoundId: SystemSoundID = 1304;
        AudioServicesPlaySystemSound(systemSoundId);
    }
    
    @objc func updateTimer() {
        if(secondsLeft < 1) {
            timer.invalidate();
            isTimerRunning = false;
            timerLights.showTimeIsUp();
            playSoundTimeIsUp();
            //Send alert
        }
        else {
            secondsLeft -= 1;
            timerLights.selectLightsBasedOnSecondsLeft(seconds: secondsLeft);
        }
    }


}

