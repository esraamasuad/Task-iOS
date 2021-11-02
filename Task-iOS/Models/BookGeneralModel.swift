//
//  BookGeneralModel.swift
//  Task-iOS
//
//  Created by Esraa on 02/11/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import Foundation

struct BookGeneralModel: Codable {
    var list_name: String?
    var display_name: String?
    var bestsellers_date: String?
    var published_date: String?
    var rank: Int?
    var rank_last_week: Int?
    var weeks_on_list: Int?
    var asterisk: Int?
    var dagger: Int?
    var amazon_product_url: String?
    var book_details: [BookDetailsModel]?
}

struct BookDetailsModel: Codable {
    var title: String?
    var description: String?
    var contributor: String?
    var author: String?
    var contributor_note: String?
    var price: String?
    var age_group: String?
    var publisher: String?
}

