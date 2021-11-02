//
//  BookDetailsItem.swift
//  Task-iOS
//
//  Created by Esraa on 12/10/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import Foundation

class BookDetailsItem: BaseItem {
    var bookDetails:BookGeneralModel?
    
    init(_ bookDetails: BookGeneralModel?) {
        self.bookDetails = bookDetails
    }
}
