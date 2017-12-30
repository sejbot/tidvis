//
//  ViewController.swift
//  TidVis
//
//  Created by Tobias Glosboken on 2017-12-30.
//  Copyright © 2017 Bulleriberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SelectTimeControlDelegate {
    
    //MARK: Properties
    @IBOutlet weak var TimeLeftLabel: UILabel!
    @IBOutlet weak var selectTimeControl: SelectTimeControl!
    @IBOutlet weak var timerLights: TimerLights!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTimeControl.delegate = self;
    }
    
    func didPressButton(button: UIButton) {
        let secondsLeft = Int((button.titleLabel?.text)!)!;
        TimeLeftLabel.text = button.titleLabel?.text;
        timerLights.selectLightsBasedOnSecondsLeft(seconds: secondsLeft);
    }


}

