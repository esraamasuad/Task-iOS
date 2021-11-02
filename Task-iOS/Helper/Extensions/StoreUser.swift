//
//  StoreUser.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//


import Foundation
import SwiftyJSON


extension UserDefaults {
    
    func storeUserData(user:UserModel) {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(user)
            set(jsonData, forKey: "userData")
            synchronize()
        }
        catch _ as NSError {
            
        }
    }
    
    func getStoredUser()->UserModel? {
        if let _ = value(forKey: "userData") {
            do {
                let decoder = JSONDecoder()
                let decodedUser = try decoder.decode(UserModel.self, from: value(forKey: "userData")! as! Data)
                return decodedUser
            }
            catch _ as NSError {
                return nil
            }
        }
        return nil
    }
         
    func setUserToken(_ token: String) {
        set(token, forKey: "userToken")
        synchronize()
    }
    
    func getUserToken()->String? {
        if let  userToken = value(forKey: "userToken") {
            return userToken as? String
        }
        return ""
    }
    
    func userIsLogIn()->Bool {
        if let _ = getStoredUser() {
            return true
        }
        else {
            return false
        }
    }
    
    func userLanguage()->String {
        if let  currentLang = value(forKey: "userlanguage") {
            return currentLang as! String
        }else{
            let locale = NSLocale.current.languageCode ?? ""
            return  (locale == "en-US" || locale == "en") ? "en" : "ar"
        }
    }
    
    func setUserLangauge(userLanguage : String) {
        set(userLanguage, forKey: "userlanguage")
        synchronize()
    }
    
    func userOpenIntro() {
        set(true, forKey: "introScreens")
        synchronize()
    }
    
    func checkIntro()->Bool {
        if let _ = value(forKey: "introScreens") {
            return true
        }
        else{
            userOpenIntro()
            return false
        }
    }
    
    func removeLoggedUser() {
        removeObject(forKey: "userData")
        synchronize()
    }
    func removeUserToken() {
        removeObject(forKey: "userToken")
        synchronize()
    }
    
    func storeFCM(key: String) {
        removeObject(forKey: "FCM")
        do {
            set(key, forKey: "FCM")
            synchronize()
        }
     }
    
    func getFCM()->String? {
        if let _ = value(forKey: "FCM") {
            do {
                let id =  value(forKey: "FCM")! as! String
                return id
            }
        }
        return ""
    }
    
}
