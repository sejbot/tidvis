//
//  SelectTimeControl.swift
//  TidVis
//
//  Created by Tobias Glosboken on 2017-12-30.
//  Copyright © 2017 Bulleriberg. All rights reserved.
//

import UIKit

@IBDesignable class SelectTimeControl: UIStackView {
    
    var delegate: SelectTimeControlDelegate!;
    var timeButtons = [UIButton]();
    var buttonValues = [String]();
    var buttonCount = 4;
    var buttonDiameter: CGFloat = 88.0;
    var borderColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1);

    override init(frame: CGRect) {
        super.init(frame: frame);
        //setupButtons(["5","10","15","20"]);
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        //setupButtons(["5","10","15","20"]);
    }
    
    //MARK: Private methods
    public func setupButtons(_ buttonValues: [String]) {
        self.buttonValues = buttonValues;
        //Remove buttons
        for button in timeButtons {
            removeArrangedSubview(button);
            button.removeFromSuperview();
        }
        timeButtons.removeAll();
        
        //Add buttons
        addTimerButton(title: buttonValues[0], color: UIColor.blue);
        addTimerButton(title: buttonValues[1], color: UIColor.green);
        addTimerButton(title: buttonValues[2], color: UIColor.orange);
        addTimerButton(title: buttonValues[3], color: UIColor.red);
        
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
        button.layer.borderWidth = floor(buttonDiameter/28);
        button.layer.borderColor = borderColor.cgColor;
        button.setTitle(title, for: .normal);
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 36);
        
        
        //Add accessibility label
        //button.accessibilityLabel = "Set \(index + 1) star rating";
        //Setup the button action
        button.addTarget(self, action: #selector(SelectTimeControl.buttonPressed(button:)), for: .touchUpInside);
        
        //Add the button to the stack
        addArrangedSubview(button);
        
        //Add the new button to the array
        timeButtons.append(button);
    }
    
    @objc func buttonPressed(button: UIButton) {
        delegate.didPressButton(button:button);
    }

}
