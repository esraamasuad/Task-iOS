//
//  BaseRequestHandler.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

typealias JSONTaskCompletionHandler<T> = ((NetworkResponse<T>) -> Void)?

protocol BaseRequestHandler:BaseResponseHandler {
    func send<T: Codable>(_ decoder: T.Type, completion: JSONTaskCompletionHandler<T>)
    func uploadMultiPart<T: Codable>(_ decoder: T.Type,data:[MultiPartModel],completion: JSONTaskCompletionHandler<T>)
    func uploadDataWithMultiPart<T: Codable>(_ decoder: T.Type,data:[MultiPartModel], completion: JSONTaskCompletionHandler<T>)
}

extension BaseRequestHandler where Self: BaseRequestBuilder {
    
    func send<T: Codable>(_ decoder: T.Type, completion: JSONTaskCompletionHandler<T>) {        URLCache.shared.removeAllCachedResponses()
//        let configuration = URLSessionConfiguration.default
//          configuration.urlCache = nil
        request(self).validate().responseData {(response) in
            print("----------------\(response)")
            self.handleResponse(response, completion: completion)
        }
    }
    
    func uploadMultiPart<T: Codable>(_ decoder: T.Type,data:[MultiPartModel],
                                     completion: JSONTaskCompletionHandler<T>) {
        
        upload(multipartFormData: { (multipart) in
            
            for item in data {
                multipart.append(item.data, withName: "\(item.keyName)" , fileName: item.fileName, mimeType: item.mimeType)
            }
            guard let params = self.parameters else { return }
            for (key, value) in params {
                multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, with: self) { (result) in
            
            switch result{
            case .success(let upload, _, _):
               upload.uploadProgress { (progress) in
                    let n = Float(progress.fractionCompleted)
                    let progressValue:[String:Float] = ["progress":n]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "inProgress"), object: nil, userInfo: progressValue)
                }
                upload.responseData(completionHandler: { (results) in
                    self.handleResponse(results, completion: completion)
                })
            case .failure(let error):
                completion?(NetworkResponse<T>.error(error.localizedDescription))
            }
        }
    }
    
    func uploadDataWithMultiPart<T: Codable>(_ decoder: T.Type,data:[MultiPartModel],
                                             completion: JSONTaskCompletionHandler<T>) {
        upload(multipartFormData: { (multipart) in
            for item in data {
                multipart.append(item.data, withName: item.keyName, fileName: item.fileName, mimeType: item.mimeType)
            }
            guard let params = self.parameters else { return }
            for (key, value) in params {
                    multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, with: self) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                 upload.uploadProgress { (progress) in
                    let n = Float(progress.fractionCompleted)
                    let progressValue:[String:Float] = ["progress":n]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "inProgress"), object: nil, userInfo: progressValue)
                }
                upload.responseData(completionHandler: { (results) in
                   // AppReference.currentVC?.navigationController?.finishProgress()
                    self.handleResponse(results, completion: completion)
                })
            case .failure(let error):
                print("🥵🥵🥵🥵🥵\(error)")
                completion?(NetworkResponse<T>.error(error.localizedDescription))
            }
        }
    }
}




