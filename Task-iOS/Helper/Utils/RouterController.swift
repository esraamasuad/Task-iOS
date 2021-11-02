//
//  RouterController.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/6/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

enum Storyboard: String {
    case main = "Main"
    case auth = "Authentication"
    case details = "Details"
    case profile = "Profile"
    case providerProfile = "ProviderProfile+Products"
    case addProduct = "AddProduct"
    case publishStatus = "PublishStatus"
    case settings = "Settings"
}

enum View: String {
    
    //Main
    case homeListView = "HomeListView"
    case bookDetailsView = "BookDetailsView"
    
    private var storyboard: Storyboard {
        switch self {
        case .homeListView, .bookDetailsView:
            return .main
        }
    }
    
    func controller<Presenter: BasePresenter, Item: BaseItem>(presenterType: Presenter.Type, item: Item) -> BaseVC<Presenter, Item> {
        let controller = UIStoryboard.init(name: storyboard.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: rawValue)
            as! BaseVC<Presenter, Item> //swiftlint:disable:this force_cast
        controller.item = item
        return controller
    }
    
    func identifyViewController<viewController: UIViewController>(viewControllerType: viewController.Type) -> viewController {
        let controller = UIStoryboard.init(name: storyboard.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: rawValue)
            as! viewController //swiftlint:disable:this force_cast
        return controller
    }
    
    func baseController<viewController: UIViewController>(viewControllerType: viewController.Type) -> viewController {
        let controller = UIStoryboard.init(name: storyboard.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: rawValue)
            as! viewController //swiftlint:disable:this force_cast
        return controller
    }
}

protocol RouterManagerProtocol {
    func push<Presenter: BasePresenter, Item: BaseItem>(view: View, presenter: Presenter.Type, item: Item )
    func push(vc: UIViewController)
    func present<Presenter: BasePresenter, Item: BaseItem>(view: View, presenter: Presenter.Type, item: Item)
    func startScreen<viewController: UIViewController>(view: View, controller: viewController.Type)
    func popBack()
    func dismiss()
    func present(vc: UIViewController)
}

class RouterManager: RouterManagerProtocol {
    
    var currentViewController: UIViewController
    
    init(_ currentViewController: UIViewController) {
        self.currentViewController = currentViewController
    }
    
    func present<Presenter: BasePresenter, Item: BaseItem>(view: View, presenter: Presenter.Type, item: Item) {
        let viewController = view.controller(presenterType: presenter, item: item)
        currentViewController.present(viewController, animated: true)
    }
    
    func push<Presenter: BasePresenter, Item: BaseItem>(view: View, presenter: Presenter.Type, item: Item ) {
        let viewController = view.controller(presenterType: presenter, item: item)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func push(vc: UIViewController) {
        currentViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func startScreen<viewController: UIViewController>(view: View, controller: viewController.Type) {
        let viewController = view.baseController(viewControllerType: controller)
        currentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popBack() {
        _ = currentViewController.navigationController?.popViewController(animated: true)
    }
    func dismiss() {
        _ = currentViewController.dismiss(animated: true, completion: nil)
    }
    
    func present(vc: UIViewController) {
        _ = currentViewController.present(vc, animated: true, completion: {
            let vcc = vc as? AVPlayerViewController
            if vcc != nil {
                vcc?.player?.play()
            }
        })
    }
    
}
