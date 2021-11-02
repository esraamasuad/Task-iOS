//
//  Constants.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation

struct Constants {
    static func isOpenAppFirstTime() -> Bool{
         let firstTime = UserDefaults.standard.object(forKey: "appOpenedForFristTime")
         UserDefaults.standard.set(false, forKey: "appOpenedForFristTime")
        return (firstTime == nil) ? true : false
    }
    
    static var reservationNotification = NSNotification.Name(rawValue: "routeToReservation")
}
