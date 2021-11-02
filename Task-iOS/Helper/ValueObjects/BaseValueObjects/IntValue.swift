//
//  File.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation

class IntValue: ValueObject {
    
    var value: Int = 0
    

    init(_ value: Int?) {
        self.value = value ?? 0
    }
    
     func isPresent() -> Bool {
        return value != 0
    }
}
