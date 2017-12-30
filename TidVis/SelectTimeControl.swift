//
//  SelectTimeControl.swift
//  TidVis
//
//  Created by Tobias Glosboken on 2017-12-30.
//  Copyright © 2017 Bulleriberg. All rights reserved.
//

import UIKit

@IBDesignable class SelectTimeControl: UIStackView {
    
    var timeButtons = [UIButton]();
    
    var buttonCount = 4;
    
    var buttonDiameter: CGFloat = 88.0;

    override init(frame: CGRect) {
        super.init(frame: frame);
        setupButtons();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        setupButtons();
    }
    
    //MARK: Private methods
    private func setupButtons() {
        
        //Remove buttons
        for button in timeButtons {
            removeArrangedSubview(button);
            button.removeFromSuperview();
        }
        timeButtons.removeAll();
        
        addTimerButton(title: "5", color: UIColor.blue);
        addTimerButton(title: "10", color: UIColor.green);
        addTimerButton(title: "15", color: UIColor.orange);
        addTimerButton(title: "20", color: UIColor.red);
        
        //updateButtonSelectedStates();
    }
    
    private func addTimerButton(title: String, color: UIColor) {
        let button = UIButton();
        button.backgroundColor = color;
        
        //Add constraints
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.heightAnchor.constraint(equalToConstant: buttonDiameter).isActive = true;
        button.widthAnchor.constraint(equalToConstant: buttonDiameter).isActive = true;
        //button.layer.masksToBounds = true;
        button.layer.cornerRadius = buttonDiameter / 2;
        button.clipsToBounds = true;
        button.layer.borderWidth = floor(buttonDiameter/14);
        button.layer.borderColor = UIColor.white.cgColor;
        button.setTitle(title, for: .normal);
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 36);
        
        
        //Add accessibility label
        //button.accessibilityLabel = "Set \(index + 1) star rating";
        //Setup the button action
        //button.addTarget(self, action: #selector(SelectTimeControl.ratingButtonTapped(button:)), for: .touchUpInside);
        
        //Add the button to the stack
        addArrangedSubview(button);
        
        //Add the new button to the array
        timeButtons.append(button);
    }

}
