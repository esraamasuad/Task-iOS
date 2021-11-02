//
//  BaseRequestBuilder.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import Foundation
import Alamofire
extension String {
    func encodeUrl() -> String {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
    
    func decodeUrl() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

extension String {
    func asClean()->String {
        if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return urlEscapedString
        }
        else {
            return ""
        }
    }
}

protocol BaseRequestBuilder: URLRequestConvertible,BaseRequestHandler {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    
    // MARK: - Path
    var path: String { get }
    
    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    // MARK: - Headers
    var headers: [String:String] { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
}


//default initialization

extension BaseRequestBuilder {
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var mainURL: URL  {
        return URL(string: AppReference.baseUrl)!
    }
    
    var method: HTTPMethod  {
        return .get
    }
    
    var parameters: Parameters?  {
        return nil
    }
    
    var headers: [String:String]  {
        return ["Authorization": ("Bearer " + UserDefaults.standard.getUserToken()!),
                "Accept": "application/json",
                "Lang-App": SetLangauge.currentAppleLanguage(),
                "Accept-Language" :SetLangauge.currentAppleLanguage(),
                "Cookie": ""]
    }
    
    var requestURL: URL {
        let strUrl = mainURL.appendingPathComponent(path).absoluteString.decodeUrl()
        return URL(string: strUrl)!
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        print("\(method.rawValue) --  \(requestURL.absoluteString)")
        print("Params --- \(parameters ?? [:]) --")
        print("headers --- \(headers) --")
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
