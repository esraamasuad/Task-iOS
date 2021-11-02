//
//  BaseVM.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import Bond

class BasePresenter {
    
    init() {
        hydrate()
    }
    
    func hydrate() {}
    
    var successMessage = Dynamic<String>("")
    var popUpMessage = Dynamic<(String, String)>(("", ""))
    var errorMessage = Dynamic<String>("")
    var isLoading: Dynamic<Bool> = Dynamic(false)

    func showLoading() {
        isLoading.value = true
    }
    
    func hideLoading() {
        isLoading.value = false
    }

}
