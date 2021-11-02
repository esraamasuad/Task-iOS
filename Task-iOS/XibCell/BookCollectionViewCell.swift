//
//  BookCollectionViewCell.swift
//  Task-iOS
//
//  Created by Esraa on 02/11/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var publishedByLbl: UILabel!
    @IBOutlet weak var publishedDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ details: BookGeneralModel?) {
        let bookDetails = details?.book_details?.first
        titleLbl.text = bookDetails?.title ?? ""
        publishedByLbl.text = bookDetails?.publisher ?? ""
        publishedDateLbl.text = details?.published_date
    }

}
