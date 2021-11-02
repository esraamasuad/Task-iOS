//
//  SetLang.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import UIKit

/// SetLangauge
class SetLangauge {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let currentLanguage = UserDefaults.standard.userLanguage()
        return currentLanguage
    }
    
    class func currentAppleLanguageFull() -> String{
        let current =  UserDefaults.standard.userLanguage()
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        UserDefaults.standard.setUserLangauge(userLanguage: lang)
            if lang != "en" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
                UITextView.appearance().textAlignment = .right
                UITableView.appearance().semanticContentAttribute = .forceRightToLeft
                UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
                UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
                UIScrollView.appearance().semanticContentAttribute = .forceRightToLeft
            }
            else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
                UITextView.appearance().textAlignment = .left
                UITableView.appearance().semanticContentAttribute = .forceLeftToRight
                UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
                UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
                UIScrollView.appearance().semanticContentAttribute = .forceLeftToRight
            }
        UILabel.appearance().substituteFontName = "AppRegularFont".localized()
        UILabel.appearance().substituteFontNameBold = "AppBoldFont".localized()
    }
    
//    class var isRTL: Bool {
//        return SetLangauge.currentAppleLanguage() == "ar"
//    }
}
