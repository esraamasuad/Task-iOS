//
//  BooksListView.swift
//  Books-iOS
//
//  Created by Esraa on 20/09/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import UIKit

class BooksListView: BaseVC<BooksListVM, BaseItem> {
    
    let cellIdintifier = String(describing: BookCollectionViewCell.self)
    @IBOutlet weak var booksCollectionView: UICollectionView!{
        didSet{
            self.booksCollectionView.registerCell(idintifier: cellIdintifier)
        }
    }
    
    private let refreshControl = UIRefreshControl()
    
    override func bindind() {
        setCustomNavagationBar()
        presenter = BooksListVM(router: RouterManager(self))        
        presenter.booksList.bind { (item) in
            self.refreshControl.endRefreshing()
            self.booksCollectionView.reloadData()
        }
        initTableWithRefreshController()
        presenter.reload()
    }
    
    func initTableWithRefreshController() {
        if #available(iOS 10.0, *) {
            booksCollectionView.refreshControl = refreshControl
        } else {
            booksCollectionView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func pullToRefresh(_ sender: Any) {
        presenter.reload()
    }
    
}

//MARK:- Colection Delegate
extension BooksListView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.booksList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdintifier, for: indexPath) as! BookCollectionViewCell
        let bookDetails = presenter.booksList.value[indexPath.row]
        cell.configure(bookDetails)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookdetails = presenter.booksList.value[indexPath.row]
        presenter.gotoBookDetailsView(bookdetails)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width)
        // let height = collectionView.bounds.height
        return CGSize(width: width, height: 100)
    }
}
