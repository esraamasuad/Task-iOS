//
//  Loader.swift
//  JamalTrading
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 WaysGroup. All rights reserved.
//


import Foundation
import JGProgressHUD

struct Loader {
    static let hud = JGProgressHUD(style: .dark)
    
    static func show() {
        showHud()
    }
    static func hide() {
        base.hud.dismiss()
    }
    
    static func showHud() {
        if AppReference.currentVC != nil {
            base.hud.show(in: AppReference.currentVC!.view, animated: true)
        }
    }
    
    static func showLoadingHUD(progress:Int) {
        hud.vibrancyEnabled = true
        if arc4random_uniform(2) == 0 {
            hud.indicatorView = JGProgressHUDPieIndicatorView()
        }
        else {
            hud.indicatorView = JGProgressHUDRingIndicatorView()
        }
        hud.detailTextLabel.text = "\(progress) " + "complete".localized()
        hud.progress = Float(exactly: progress)!
        hud.textLabel.text =  "uploading..".localized()
        hud.show(in:AppReference.currentVC!.view)
        
        if progress >= 100 {hud.dismiss()}
        
    }
    
    
}
