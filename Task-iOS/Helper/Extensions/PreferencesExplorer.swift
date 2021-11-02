//
//  File.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 6/3/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import UIKit

public enum PreferenceType: String {
    
    case general = "General"
    case network = "General&path=Network"
    case phone = "tel://"
    case photos = "Photos"
    case safari = "Safari"
    case facebook = "Face"
    case twitter = "Twitter"
    case instagram = "insta"
    case wifi = "WIFI"
    case mail = "mailto:"
    case store = "itms-apps://itunes.apple.com/app/"
    case whatsApp = "https://api.whatsapp.com/send?phone="

}
//
//func makeCall(num: Int){
//    if let url = URL(string: "tel://\(num)") {
//      //  UIApplication.shared.openURL(url)
//      //  let url: NSURL = URL(string: "TEL://1234567890")! as NSURL
//
//        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
//
//    }
//}

open class PreferencesExplorer {
    
    // MARK: - Class properties -
    
    static private let preferencePath = "App-Prefs:root"
    
    // MARK: - Class methods -
    
    static func open(_ preferenceType: PreferenceType,contact:String) {
        let appPath = "\(preferenceType.rawValue)"
        let urlPath = appPath != "Face" && appPath != "Twitter" && appPath != "insta" && appPath != "Safari" ? (appPath+contact): contact
        if let url = URL(string: urlPath) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open( url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL( url)
            }
        }
        
    }
}
