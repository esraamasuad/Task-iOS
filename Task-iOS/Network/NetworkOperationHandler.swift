//
//  NetworkOperationHandler.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 5/18/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//


import Foundation
//import JGProgressHUD

struct NetworkOperationHandler<T:Codable> {
    
    func execute(endPoint : BaseRequestBuilder, viewModel:BasePresenter = BasePresenter(), showLoader:Bool = true,showHud:Bool = false, completionBlock:@escaping (_ response:BaseResposne<T>)->Void){
        if showLoader {
            Loader.show()
        }
        
        endPoint.send(BaseResposne<T>.self) { (response) in
            if showLoader {
                Loader.hide()
            }
            switch response {
            case .error(_) : break;
            case .success(let value, let code) :
                do {
                    if code == 401 {
                        viewModel.errorMessage.value = value.errorsAsString
                        UserDefaults.standard.removeUserToken()
                        UserDefaults.standard.removeLoggedUser()
                        // SplashPresenter(window: AppReference.window!).decideInitScreen()
                        return
                    }
                    let  status = value.status ?? ""
                    if status == "OK" || code == 200 {
                        completionBlock(value)
                    }else {
                        viewModel.popUpMessage.value = ("error".localized(), value.errorsAsString)
                    }
                }
            }
        }
    }
    
    func upload(endPoint : BaseRequestBuilder,viewModel:BasePresenter,data:[MultiPartModel], completionBlock:@escaping (_ response:BaseResposne<T>)->Void) {
        Loader.showHud()
        endPoint.uploadMultiPart(BaseResposne<T>.self, data: data ){ (response) in
            Loader.hide()
            switch response {
            case .error(_) : break;
            case .success(let value, _) :
                do {
                    let  status = value.status ?? ""
                    if status == "OK"{
                        completionBlock(value)
                    }else {
                        viewModel.popUpMessage.value = ("error".localized(), value.errorsAsString)
                    }
                }
            }
        }
    }
    
    func uploadimageWithData(endPoint : BaseRequestBuilder,viewModel:BasePresenter,data:[MultiPartModel], completionBlock:@escaping (_ response:BaseResposne<T>)->Void) {
        endPoint.uploadDataWithMultiPart(BaseResposne<T>.self, data: data ){ (response) in
            Loader.hide()
            switch response {
            case .error(_) : break;
            case .success(let value, let code) :
                do {
                    if code == 401 {
                        viewModel.errorMessage.value = value.errorsAsString
                        UserDefaults.standard.removeUserToken()
                        UserDefaults.standard.removeLoggedUser()
                        //   SplashPresenter(window: AppReference.window!).decideInitScreen()
                        return
                    }
                    let  status = value.status ?? ""
                    if status == "OK"{
                        completionBlock(value)
                    }else {
                        viewModel.popUpMessage.value = ("error".localized(), value.errorsAsString)
                    }
                }
            }
        }
    }
}
