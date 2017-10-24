//
//  CustomTextField.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 04.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

class CustomTextField : SkyFloatingLabelTextField {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.placeholderColor   = UIColor.lightGray
        self.lineColor          = UIColor.lightGray
        self.selectedLineColor  = UIColor.lightGray
    }
    
}
