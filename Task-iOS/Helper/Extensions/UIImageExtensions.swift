//
//  UIImageExtensions.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/20/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Kingfisher

extension UIImageView {

    func loadWebImageWithUrl(imageUrl:String) {
        let image = ( imageUrl)
        let urlStr = image.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        loadWebImage(imageUrl: urlStr!, placeHolder: UIImage(named: "placeholder_image")!)
    }
    
    private func loadWebImage(imageUrl:String , placeHolder:UIImage) {
        self.startAnimating()
       self.kf.indicatorType = .activity
        let url = URL(string: imageUrl)
        self.kf.setImage(with: url,
                         placeholder: placeHolder,
                         options: [.transition(.fade(1))],
                         progressBlock: nil,
                         completionHandler: nil)

    }
    
    /*-- image animation --*/
    func animateImage(){
        
        UIView.animate(withDuration: 1, animations: {
            self.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (_) in
            UIView.animate(withDuration: 1, animations: {
                self.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (_) in
                UIView.animate(withDuration: 1, animations: {
                    self.transform = CGAffineTransform.identity
                })
            })
        })
    }
}

