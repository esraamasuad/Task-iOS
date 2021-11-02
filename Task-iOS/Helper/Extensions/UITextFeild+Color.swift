//
//  UITextFeild+Color.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var inset: CGFloat = 0
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y,
            width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
            .insetBy(dx: inset, dy: inset)
    }
    

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

}


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
   
}


@IBDesignable
class DesignTextField: UITextField {
   
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        
        if let image = rightImage {
            
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 15, height: 15))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            let view = UIView(frame: CGRect(x: 0 , y: 0, width: 30, height: 20))
            view.addSubview(imageView)
        
            rightView = view
        } else {
        
          rightViewMode = .always
        }
    }
}
