//
//  DoubleValue.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation

class DoubleValue: ValueObject {
    
    var value: Double = 0.0
    
   

    init(_ value: Double?) {
        self.value = value ?? 0.0
    }
    
     func isPresent() -> Bool {
        return value != 0.0
    }
}
