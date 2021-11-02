//
//  PickImageManger.swift
//  Photonect-IOS
//
//  Created by Esraa Masuad on 8/15/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//
//
//import Foundation
//import YPImagePicker
//
//protocol PickImageProtocol {
//    func selectImage (_ maxNumberOfItems: Int,image: @escaping (_ image :[YPMediaItem] ) -> Void)
//}
//
//class PickImageManager: PickImageProtocol {
//    
//    var viewController: UIViewController
//    
//    init(_ currentViewController: UIViewController) {
//        self.viewController = currentViewController
//    }
//    
//    func selectImage(_ maxNumberOfItems: Int,image: @escaping ([YPMediaItem]) -> Void) {
//        var config = YPImagePickerConfiguration()
//        config.screens = [.library, .photo]
//        config.hidesStatusBar = true
//        config.library.mediaType = .photo
//        config.showsPhotoFilters = false
//        config.library.maxNumberOfItems = maxNumberOfItems
//        let picker = YPImagePicker(configuration: config)
//        picker.didFinishPicking { [unowned picker] items, _ in
//            image(items)
//            picker.dismiss(animated: true, completion: nil)
//        }
//        viewController.present(picker, animated: true, completion: nil)
//    }
//}
//
