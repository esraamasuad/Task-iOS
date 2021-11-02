//
//  CustomClasses.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import UIKit

class CustomCornerView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let current_lang = SetLangauge.currentAppleLanguage()
        
        let item_tag  = self.tag
        if item_tag < 0 {
            
            self.layer.cornerRadius = CGFloat(-1*item_tag)
            self.layer.maskedCorners = (current_lang == "en") ? [.layerMaxXMinYCorner, .layerMinXMaxYCorner] :[.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        }
        else {
            self.layer.cornerRadius = CGFloat(item_tag)
            self.layer.maskedCorners = (current_lang == "en") ?   [.layerMinXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
}

class CustomTopCornerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        self.layer.cornerRadius = CGFloat(self.tag)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

class CustomShadow: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = CGFloat(self.tag)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        self.shadowColor = UIColor.lightGray2Color
       self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.3
        
    }
     
}


class RTLButtonView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         if SetLangauge.currentAppleLanguage() == "ar" {
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }
     
}

class RTLImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         if SetLangauge.currentAppleLanguage() == "ar" {
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }
     
}

