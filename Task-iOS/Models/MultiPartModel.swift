//
//  MultiPartModel.swift
//  Task-iOS
//
//  Created by Esraa on 01/11/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import Foundation

struct MultiPartModel {
    var data: Data
    var fileName, mimeType, keyName: String
}
struct UploadImageModel: Codable {
    let url: String?
    let updatedAt, createdAt: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case url
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
