//
//  Password.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation

class Password: StringValue {
    
    func isValid() -> Bool {
        return value.count >= 6
    }
}
