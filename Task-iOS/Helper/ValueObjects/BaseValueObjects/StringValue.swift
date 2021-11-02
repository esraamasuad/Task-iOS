//
//  StringValue.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation


class StringValue: ValueObject {
    
    var value: String = ""
    
    init(_ value: String?) {
        self.value = value ?? ""
    }
    
     func isPresent() -> Bool {
        return value != ""
    }
}
