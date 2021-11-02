//
//  AppReferance.swift
//  iOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
import FCAlertView

struct AppReference {
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let baseUrl = "https://api.nytimes.com/"
    static let frame = UIScreen.main.bounds
    
    static var fcm_token :String {
        return  ""
    }
    
    static var currentVC:UIViewController? {
        return appDelegate.window?.rootViewController
    }
    
    static var window: UIWindow? {
        return appDelegate.window
    }
    
    static func showLoginDialog(vc:UIViewController? = AppReference.currentVC) {
    }
    
    static let googleMapsKey = ""
    
    static func showAlertMessage(title: String, message: String, theme: Theme) {
        let success = MessageView.viewFromNib(layout: .messageView)
        success.configureTheme(theme)
        success.configureDropShadow()
        success.configureContent(title: title, body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.dimMode = .blur(style: .dark, alpha: 0.4, interactive: true)
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level.normal.rawValue))
        success.backgroundColor = UIColor.assetColor
        SwiftMessages.show(config: successConfig, view: success)
    }
    
    static func makeErrorAlert(title: String, SubTitle: String, _ is_success: Bool) {
        let alert = FCAlertView()
        is_success ? alert.makeAlertTypeSuccess() :  alert.makeAlertTypeCaution()
        alert.subtitleFont = UIFont(name: "AppRegularFont".localized(), size: 12)
        alert.colorScheme = UIColor.red
        alert.doneButtonTitleColor = UIColor.white
        alert.dismissOnOutsideTouch = true
        alert.autoHideSeconds = 4
        alert.hideDoneButton = true
        alert.bounceAnimations = true
        alert.animateAlertOutToTop = true
        alert.showAlert(withTitle: title, withSubtitle: SubTitle, withCustomImage: UIImage(named: "logo_icon"), withDoneButtonTitle: "ok".localized(), andButtons: nil)
    }

    public static func showAlertMessage(route : RouterManagerProtocol,title: String, SubTitle: String, vc: UINavigationController? = nil) {
        let alert = FCAlertView()
        alert.makeAlertTypeCaution()
        alert.colorScheme = UIColor.assetColor
        alert.dismissOnOutsideTouch = true
        
        alert.addButton("Cancel".localized()) {
            alert.dismiss()
        }
        
        alert.addButton("Ok".localized()) {
        }
        
        alert.titleFont = UIFont(name: "AppRegularFont".localized(), size: 14)
        alert.showAlert(withTitle: title, withSubtitle: nil, withCustomImage: nil, withDoneButtonTitle: nil , andButtons: nil)
        
        alert.secondButtonBackgroundColor = UIColor.assetColor
        alert.secondButtonTitleColor = UIColor.white
        
        alert.hideDoneButton = true
    }
    
}
