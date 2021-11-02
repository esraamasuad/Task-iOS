//
//  File.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation

struct BaseResposne<T: Codable>: Codable {
    var status: String?
    var copyright: String?
    var last_modified: String?
    var num_results: Int?
    let errors: [String]?
    var results: T?
    
    var errorsAsString: String {
        return errors?.joined(separator: "\n") ?? ""
    }
}


