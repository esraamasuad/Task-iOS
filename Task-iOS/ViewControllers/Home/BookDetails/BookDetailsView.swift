//
//  BookDetailsView.swift
//  Task-iOS
//
//  Created by Esraa on 20/09/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import UIKit
import MXParallaxHeader

class BookDetailsView: BaseVC<BookDetailsVM, BookDetailsItem> {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var publishedByLbl: UILabel!
    @IBOutlet weak var publishedDateLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var autherLbl: UILabel!
    
    override func bindind() {
        setCustomNavagationBar()
        presenter = BookDetailsVM(router: RouterManager(self), item.bookDetails)
        presenter.title.bind(to: titleLbl)
        presenter.publishedBy.bind(to: publishedByLbl)
        presenter.publishedDate.bind(to: publishedDateLbl)
        presenter.category.bind(to: categoryLbl)
        presenter.auther.bind(to: autherLbl)
        presenter.description.bind(to: descriptionLbl)
        presenter.price.bind(to: priceLbl)
        
        setupHeaderView()
        presenter.setData()
    }
    
    func setupHeaderView()  {
        scrollView.parallaxHeader.view = headerView
        scrollView.parallaxHeader.height = 320
        scrollView.parallaxHeader.minimumHeight = 150
        scrollView.parallaxHeader.mode = .fill
        headerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}

extension BookDetailsView {
    @IBAction func buyAction(_ button: UIButton){
        presenter.buy()
    }
}
