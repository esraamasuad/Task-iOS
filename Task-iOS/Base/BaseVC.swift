//
//  BaseVC.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import UIKit
import JGProgressHUD

var base = BaseVC()

class BaseVC<VM :BasePresenter,Item:BaseItem>:  UIViewController {
    
    var item: Item!
    var frame = AppReference.frame
    let hud = JGProgressHUD(style: .dark)

    var presenter : VM!
    {
        didSet{
            presenter.successMessage.bind({ (sucessMessage) in
                AppReference.showAlertMessage(title:   "Success".localized(),
                                             message: "\(sucessMessage)",
                    theme: .success)

            })
            presenter.popUpMessage.bind { (title, message) in
                AppReference.makeErrorAlert(title: title, SubTitle: message, false)
            }
            presenter.errorMessage.bind( { (errorMessage) in
                AppReference.showAlertMessage(title: "error".localized(),
                                             message: "\(errorMessage)",
                                             theme: .error)
            })
            presenter.isLoading.bindAndFire { (loading) in
                if loading { base.hud.show(in:self.view )
                } else {
                    base.hud.dismiss()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindind()
    }
    
    func bindind() {}
    
    //to hide last View Name with back button
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}
