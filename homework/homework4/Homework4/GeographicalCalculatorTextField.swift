//
//  GeographicalCalculatorTextField.swift
//  Homework4
//
//  Created by Josiah on 2/24/17.
//  Copyright © 2017 Josiah Campbell. All rights reserved.
//

import UIKit

class GeographicalCalculatorTextField: DecimalMinusTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1.0
        backgroundColor = UIColor.clear
        layer.borderColor = FOREGROUND_COLOR.cgColor
        layer.cornerRadius = 5.0
        textColor = FOREGROUND_COLOR
        
        guard let ph = self.placeholder else {
            return
        }
        
        attributedPlaceholder = NSAttributedString(string: ph, attributes: [
            NSForegroundColorAttributeName: FOREGROUND_COLOR])
    }

}
