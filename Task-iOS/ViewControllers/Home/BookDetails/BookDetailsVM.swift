//
//  BookDetailsVM.swift
//  Task-iOS
//
//  Created by Esraa on 20/09/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import Bond

class BookDetailsVM: BasePresenter {
    
    var router: RouterManagerProtocol!
    
    var title: Observable<String?> = Observable("")
    var description: Observable<String?> = Observable("")
    var price: Observable<String?> = Observable("")
    var publishedBy: Observable<String?> = Observable("")
    var publishedDate: Observable<String?> = Observable("")
    var category: Observable<String?> = Observable("")
    var auther: Observable<String?> = Observable("")
    var amazonUrl = ""
    var bookGeneral: BookGeneralModel?
    
    init(router: RouterManagerProtocol, _ productDetails: BookGeneralModel?) {
        self.router = router
        self.bookGeneral = productDetails
    }
    
    func setData() {
        let details = bookGeneral?.book_details?.first
        self.title.value = details?.title
        self.description.value = details?.description
        self.price.value = "\(details?.price ?? "")$"
        self.publishedBy.value = details?.publisher
        self.description.value = details?.description
        self.auther.value = details?.author
        self.publishedDate.value = bookGeneral?.published_date
        self.category.value = bookGeneral?.display_name
        self.amazonUrl = bookGeneral?.amazon_product_url ?? ""
    }
    
    func buy() {
        PreferencesExplorer.open(.safari, contact: amazonUrl)
    }
  
}
