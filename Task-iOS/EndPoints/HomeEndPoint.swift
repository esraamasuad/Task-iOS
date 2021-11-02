//
//  HomeEndPoint.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//


import Alamofire

enum HomeEndpoint :BaseRequestBuilder {
    
    case getHome
    
    var path: String {
        switch self {
        case .getHome:
            return "svc/books/v3/lists.json"
        }
    }
    
    var method: HTTPMethod  {
        switch self {
        case .getHome:
            return .get
        }
    }
    
    var parameters: Parameters?  {
        switch self {
        case .getHome:
            return ["list": "hardcover-fiction",
                    "api-key": "97wyJ04G6yChOzYWcTBivL3LuWqhVKOZ"]
        }
    }
}


