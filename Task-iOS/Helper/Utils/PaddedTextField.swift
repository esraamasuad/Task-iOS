//
//  File.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//


import Foundation
import UIKit

class PaddedTextField: UITextField {
    
    @IBInspectable var paddingLeft: CGFloat = 10  //default value
    @IBInspectable var paddingRight: CGFloat = 10
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    
    override func awakeFromNib() {
//        if Language.currentLanguage() == "ar"  {
//            self.textAlignment = .right
//        } else {
//            self.textAlignment = .left
//        }
    }
}

