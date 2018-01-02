//
//  TimerLights.swift
//  TidVis
//
//  Created by Tobias Glosboken on 2017-12-30.
//  Copyright © 2017 Bulleriberg. All rights reserved.
//

import UIKit

@IBDesignable class TimerLights: UIStackView {

    //MARK: Properties
    var lights = [UIButton]();
    var lightDiameter: CGFloat = 22.0;
    var lightCount = 20;
    var normalLightColor = UIColor(red: 193/255, green: 0, blue: 0, alpha: 1);
    var selectedLightColor = UIColor(red: 255/255, green: 50/255, blue: 50/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        setupLights();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        setupLights();
    }
    
    //MARK: Public functions
    func selectLightsBasedOnSecondsLeft(seconds: Int) {
        let minutesLeft: Int = seconds / 60;
        for (index, light) in lights.enumerated() {
            if(index <= minutesLeft ) {
                light.backgroundColor = selectedLightColor;
            }
            else {
                light.backgroundColor = normalLightColor;
            }
        }
    }
    
    func showTimeIsUp() {
        for light in lights {
            light.flashBetweenColors(fromColor: selectedLightColor, toColor: normalLightColor);
            light.backgroundColor = normalLightColor;
        }
    }
    
    func stopAnimation() {
        for light in lights {
            light.layer.removeAllAnimations();
            light.layer.layoutIfNeeded();
        }
    }
    
    //MARK: Private functions
    private func setupLights() {
        for light in lights {
            removeArrangedSubview(light);
            light.removeFromSuperview();
        }
        lights.removeAll();
        
        for index in 0..<lightCount {
            let light = UIButton();
            light.backgroundColor = normalLightColor;
            
            //Add constraints
            light.translatesAutoresizingMaskIntoConstraints = false;
            light.heightAnchor.constraint(equalToConstant: lightDiameter).isActive = true;
            light.widthAnchor.constraint(equalToConstant: lightDiameter).isActive = true;
            light.layer.cornerRadius = lightDiameter / 2;
            light.clipsToBounds = true;
            light.layer.borderWidth = floor(lightDiameter/10);
            light.layer.borderColor = UIColor.black.cgColor;
            
            addArrangedSubview(light);
            
            lights.append(light);
        }
    }
    
}
