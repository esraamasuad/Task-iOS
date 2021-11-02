//
//  File.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//


import UIKit

extension UIViewController{
    
    func setTransparentNavagtionBar(_ barColor: UIColor = UIColor.barTintColor, _ title:String = "",_ isTranslucent:Bool = false){
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.tintColor = UIColor.assetColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = title
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppRegularFont".localized(), size: 18)!,
        NSAttributedString.Key.foregroundColor: UIColor.assetColor]
    }
    
    func setCustomNavagationBar(_ barColor: UIColor = UIColor.barTintColor,
                                _ title:String = "",
                                _ barItems: UIColor = UIColor.assetColor,
                                _ isTranslucent:Bool = true){
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "left_arrow_icon")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "left_arrow_icon")
        self.navigationController?.navigationBar.tintColor = barItems
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppRegularFont".localized(), size: 18)!,NSAttributedString.Key.foregroundColor: barItems]
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setCustomNavagationBar()
    }
    
    func hideStatusBar(){
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.isHidden = true
        } else {
            (UIApplication.shared.value(forKey: "statusBar")  as? UIView )?.isHidden = true
        }
    }
    
    func setStatusBarBackgroundColor(_ color: UIColor = UIColor.barTintColor) {
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            (UIApplication.shared.value(forKey: "statusBar")  as? UIView )?.backgroundColor = color
        }
        
    }
    
    //to hide last View Name with back button
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
  
}
