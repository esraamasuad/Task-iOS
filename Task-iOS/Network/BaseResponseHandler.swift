//
//  BaseResponseHandler.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

protocol BaseResponseHandler {
    func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: JSONTaskCompletionHandler<T>)
}

extension BaseResponseHandler {
    
    func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: JSONTaskCompletionHandler<T>) {
        let status = response.response?.statusCode ?? 400
        print(" handleResponse 1 \(status)")

        switch response.result {
        case .failure(let error):
            //completion?(NetworkResponse<T>.error(error.localizedDescription))
            handleResponseData(response.data ?? Data(), status, completion: completion)
            print("Connection Error 👽👽👽👽 \(error.localizedDescription)")
        case .success(let value):
                handleResponseData(value, status, completion: completion)
        }
    }
    
    private func handleResponseData<T: Codable>(_ data:Data,_ status: Int,completion: JSONTaskCompletionHandler<T>) {
         print(" handleResponse 2 \(status)")
        do {
          print("Response Data 🤪🤪🤪🤪  \(JSON(data))")
            let obj = try JSONDecoder().decode(T.self, from: data)
            completion?(NetworkResponse<T>.success(obj, status))
            
        } catch let jsonError {
            print(jsonError)
            print("JsonSerlization Error 😱😱😱😱😱 \(jsonError.localizedDescription)")
            completion?(NetworkResponse<T>.error(jsonError.localizedDescription))
        }
    }
}
