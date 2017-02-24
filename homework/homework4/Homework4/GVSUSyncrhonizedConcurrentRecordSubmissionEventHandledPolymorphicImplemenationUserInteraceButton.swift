//
//  GVSUSyncrhonizedConcurrentRecordSubmissionEventHandledPolymorphicImplemenationUserInteraceButton.swift
//  Homework4
//
//  Created by Josiah on 2/24/17.
//  Copyright © 2017 Josiah Campbell. All rights reserved.
//

import UIKit

class GVSUSyncrhonizedConcurrentRecordSubmissionEventHandledPolymorphicImplemenationUserInteraceButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = FOREGROUND_COLOR
        tintColor = BACKGROUND_COLOR
        layer.cornerRadius = 3.0
    }
}
