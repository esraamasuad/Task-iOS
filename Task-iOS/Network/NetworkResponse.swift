//
//  NetworkResponse.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T, Int), error(String?)
}
