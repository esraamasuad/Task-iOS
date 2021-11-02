//
//  CollectionViewExtension.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/21/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell(idintifier: String){
        self.register(UINib(nibName: idintifier, bundle: nil), forCellWithReuseIdentifier: idintifier)
    }
    
    func scrollToFirstItem(limit: Int){
        let num = self.numberOfItems(inSection: 0)
        if (num) >= limit {
            self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    func scrollToNextItem(){
        let num = self.numberOfItems(inSection: 0)
        let currentIndex = self.currentIndex()+1
        print("\(currentIndex), \(num)")
        if (num) > currentIndex {
            let new = IndexPath(item: currentIndex, section: 0)
            print("\(new)")
            self.scrollToItem(at: new, at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollToPreviousItem(){
        let currentIndex = self.currentIndex()-1
        if currentIndex >= 0 {
            let new = IndexPath(row: currentIndex, section: 0)
            print("\(new)")
            self.scrollToItem(at: new, at: .centeredHorizontally, animated: true)
        }
    }
    
    func currentIndex() -> Int{
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        return visibleIndexPath?.item ?? 0
    }

}

extension UITableView {
    func registerCell(idintifier: String){
        self.register(UINib(nibName: idintifier, bundle: nil), forCellReuseIdentifier: idintifier)
    }
    
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
    
    func updateFooterViewHeight() {
        if let header = self.tableFooterView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
}
