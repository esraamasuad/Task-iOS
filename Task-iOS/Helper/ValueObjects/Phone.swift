//
//  File.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation

class Phone: StringValue {
    
    func isValid() -> Bool {
//        let phoneRegex = "^(00965|965|\\+965|05|5)(5|6|9)([0-9]{7})$"
        let phoneRegex = "^(5|6|9)([0-9]{7})$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: value)
    }
}
