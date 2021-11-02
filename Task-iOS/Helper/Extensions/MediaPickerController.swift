//
//  File.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 6/3/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MobileCoreServices

public enum MediaPickerControllerType {
    case imageOnly
    case imageAndVideo
}

public protocol MediaPickerControllerDelegate {
    func mediaPickerControllerDidPickImage(_ image: UIImage)
    func mediaPickerControllerDidPickVideo(url: URL, data: Data, thumbnail: UIImage,duration : Double)
}

open class MediaPickerController: NSObject {
    
    // MARK: - Public
    
    var delegate: MediaPickerControllerDelegate?
    
    public init(type: MediaPickerControllerType, presentingViewController controller: UIViewController) {
        self.type = type
        self.presentingController = controller
        self.mediaPicker = UIImagePickerController()
        super.init()
        self.mediaPicker.delegate = self
    }
    
    open func select_type(type: MediaPickerControllerType) {
        self.type = type
    }
    
    open func show() {
        let actionSheet = self.optionsActionSheet
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = self.presentingController.view
                popoverController.sourceRect = CGRect(x: self.presentingController.view.bounds.midX, y: self.presentingController.view.bounds.height - 100, width: 0, height: 0)
                
                popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                
            }
            
            self.presentingController.present(actionSheet, animated: true, completion: nil)
        }
        else
        {
            self.presentingController.present(actionSheet, animated: true, completion: nil)
        }

    }
    
    // MARK: - Private
    
    fileprivate let presentingController: UIViewController
    fileprivate var type: MediaPickerControllerType
    fileprivate let mediaPicker: UIImagePickerController
    
}

extension MediaPickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("klkl")
        self.dismiss()
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        print(" --- \(mediaType)")
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            // Is Image
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.delegate?.mediaPickerControllerDidPickImage(chosenImage)
        } else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) {
            // Is Video
            let url: URL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            let chosenVideo = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            let videoData = try! Data(contentsOf: chosenVideo, options: [])
            let thumbnail = url.generateThumbnail()
            
            // needed only for didFinishPickingMediaWithInfo
            let outputFileURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            // get the asset
            let asset = AVURLAsset(url: outputFileURL)
            // get the time in seconds
            let durationInSeconds = asset.duration.seconds
            
            print(" --- \(url) ---\(durationInSeconds)")
            self.delegate?.mediaPickerControllerDidPickVideo(url: url, data: videoData, thumbnail: thumbnail, duration: durationInSeconds)
        }
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        print("==== done ====")
        self.dismiss()
    }
    
    // MARK: - UINavigationControllerDelegate
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

// MARK: - Private

private extension MediaPickerController {
    
    var optionsActionSheet: UIAlertController {
        let actionSheet = UIAlertController(title: Strings.Title, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        self.addChooseExistingMediaActionToSheet(actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.mediaPicker.delegate = self
            
            if self.type == .imageAndVideo {
                self.addTakeVideoActionToSheet(actionSheet)
            }
            else if self.type == .imageOnly {
                self.addTakePhotoActionToSheet(actionSheet)
            }
        }
        self.addCancelActionToSheet(actionSheet)
        return actionSheet
    }
    
    func addChooseExistingMediaActionToSheet(_ actionSheet: UIAlertController) {
        let chooseExistingAction = UIAlertAction(title: self.chooseExistingText, style: UIAlertAction.Style.default) { (_) -> Void in
            self.mediaPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.mediaPicker.mediaTypes = self.chooseExistingMediaTypes
            self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
        }
        actionSheet.addAction(chooseExistingAction)
    }
    
    func addTakePhotoActionToSheet(_ actionSheet: UIAlertController) {
        let takePhotoAction = UIAlertAction(title: Strings.TakePhoto, style: UIAlertAction.Style.default) { (_) -> Void in
            self.mediaPicker.sourceType = UIImagePickerController.SourceType.camera
            self.mediaPicker.mediaTypes = [kUTTypeImage as String]
            self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
        }
        actionSheet.addAction(takePhotoAction)
    }
    
    func addTakeVideoActionToSheet(_ actionSheet: UIAlertController) {
        let takeVideoAction = UIAlertAction(title: Strings.TakeVideo, style: UIAlertAction.Style.default) { (_) -> Void in
            self.mediaPicker.sourceType = UIImagePickerController.SourceType.camera
            self.mediaPicker.mediaTypes = [kUTTypeMovie as String]
            self.mediaPicker.videoQuality = .typeMedium
            self.mediaPicker.videoMaximumDuration = 60.0 * 5
            self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
        }
        actionSheet.addAction(takeVideoAction)
    }
    
    func addCancelActionToSheet(_ actionSheet: UIAlertController) {
        let cancel = Strings.Cancel
        let cancelAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel, handler: nil)
        actionSheet.addAction(cancelAction)
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.presentingController.dismiss(animated: true, completion: nil)
        }
    }
    
    var chooseExistingText: String {
        switch self.type {
        case .imageOnly: return Strings.ChoosePhoto
        case .imageAndVideo: return Strings.ChoosePhotoOrVideo
        }
    }
    
    var chooseExistingMediaTypes: [String] {
        switch self.type {
        case .imageOnly: return [kUTTypeImage as String]
        //case .imageAndVideo: return [kUTTypeImage as String, kUTTypeMovie as String]
        case .imageAndVideo: return [ kUTTypeMovie as String]
            
        }
    }
    
    // MARK: - Constants
    struct Strings {
        static let Title = NSLocalizedString("", comment: "Title for a generic action sheet for picking media from the device.")
        static let ChoosePhoto =  "Choose existing photo".localized()
        static let ChoosePhotoOrVideo = NSLocalizedString("Choose existing video", comment: "Text for an option that lets the user choose an existing photo or video in a generic action sheet for picking media from the device.")
        static let TakePhoto =  "Take a photo".localized()
        
        static let TakeVideo = NSLocalizedString("Take a video", comment: "Text for an option that lets the user take a video with the device camera in a generic action sheet for picking media from the device.")
        static let Cancel =  "Cancel".localized()
    }
    
}

private extension URL {
    
    func generateThumbnail() -> UIImage {
        let asset = AVAsset(url: self)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = 0
        let imageRef = try? generator.copyCGImage(at: time, actualTime: nil)
        let thumbnail = UIImage(cgImage: imageRef!)
        return thumbnail
    }
    
}
