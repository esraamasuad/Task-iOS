//
//  UIImage.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import UIKit

class UIImageValue: ValueObject {
    
    var value: UIImage = UIImage()
    
    
    
    init(_ value: UIImage?) {
        self.value = value ?? UIImage()
    }
    
    func isPresent() -> Bool {
        return value != UIImage()
    }
}
