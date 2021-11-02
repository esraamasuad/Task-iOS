//
//  BooksListVM.swift
//  Task-iOS
//
//  Created by Esraa on 20/09/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import UIKit

class BooksListVM: BasePresenter {
    var router: RouterManagerProtocol!
    var booksList: Dynamic<[BookGeneralModel]> = Dynamic([])
    
    init(router: RouterManagerProtocol) {
        self.router = router
    }
    
    func reload() {
        getListRequest()
    }
    
    func gotoBookDetailsView(_ book: BookGeneralModel?){
        router.push(view: .bookDetailsView, presenter: BookDetailsVM.self, item: BookDetailsItem(book))
    }
 
    func getListRequest(){
        self.showLoading()
        NetworkOperationHandler<[BookGeneralModel]>().execute(endPoint: HomeEndpoint.getHome, viewModel: self) { [unowned self]  in
            self.hideLoading()
            self.booksList.value = $0.results ?? []
        }
    }
}
