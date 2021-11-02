//
//  ContactHelper.swift
//  Task-iOS
//
//  Created by Esraa on 25/10/2021.
//  Copyright © 2021 Esraa Masuad. All rights reserved.
//

import Contacts
import UIKit
import Foundation

public class ContactHelper {
    
    // MARK: - Properties
    let contactStore = CNContactStore()
    private var contacts = [CNContact]()
    private var countryCode: String?
    
    
    init (countryCode: String? = nil) {
        self.countryCode = countryCode
    }
    
    public func fetchContacts(completion: @escaping(Swift.Result<[[String: String]], Error>) -> Void) {
        self.getContacts(completion: { result in
            switch result {
            case .success(let contacts):
                completion(.success(self.formatContactsfrom(CNContacts: contacts)))
                
            case .failure(let error):
                completion(.failure(error))
                break
            }
        })
    }
    
    private func formatContactsfrom(CNContacts: [CNContact]) -> [[String: String]] {
        var formattedContacts = [[String: String]]()
        let _ = CNContacts.map({ contact in
            let param: [String: String] = ["name":("\(contact.givenName) \(contact.familyName)"), "full_phone": contact.phoneNumbers.first?.value.stringValue ?? ""]
            formattedContacts.append(param)
//            do {
////                let formattedContact = PhoneContact(
////                    firstName: contact.givenName,
////                    lastName: contact.familyName,
////                    companyName: contact.organizationName,
////                    nickname: contact.nickname,
////                    //phoneNumbers: try self.formatNumbers(numbers: contact.phoneNumbers) ?? [],
////                    phoneNumbers: contact.phoneNumbers.first?.value.stringValue ?? "",
////                    thumbnailImageData: contact.thumbnailImageData
////                )
//            } catch {
//            }
        })
        return formattedContacts
    }

//    private func formatNumbers(numbers: [CNLabeledValue<CNPhoneNumber>]) throws -> [String]? {
//        guard let countryCode = self.countryCode else {
//            return numbers.map {
//                return $0.value.stringValue
//            }
//        }
//        var formattedNumbers = [String]()
//        for phoneNumber in numbers {
//
//            do {
//                let formmatedContactNumber = try  NumberValidationService().format(number: phoneNumber.value.stringValue, countryCode: countryCode) ?? "0"
//                formattedNumbers.append(formmatedContactNumber)
//            } catch {
//            }
//        }
//        return formattedNumbers
//    }
    
    private func getContacts(completion: @escaping (Swift.Result<[CNContact], Error>) -> ()) {
        requestAccess(contactStore: self.contactStore, completionHandler: { result in
            DispatchQueue.global(qos: .userInitiated).async {
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactThumbnailImageDataKey as CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                do {
                    try self.contactStore.enumerateContacts(with: request ) { (contact , stop) in
                        self.contacts.append(contact)
                    }
                    completion(.success(self.contacts))
                } catch {
                    completion(.failure(error))
                    print("unable to fetch contacts")
                }
            }
        })
    }
    
    
    func requestAccess(contactStore: CNContactStore, completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                completionHandler(true)
                
            case .denied:
                self?.showSettingsAlert(completionHandler)
                
            case .restricted, .notDetermined:
                contactStore.requestAccess(for: .contacts) { [weak self] granted, _ in
                    if granted { completionHandler(true) }
                    else { self?.showSettingsAlert(completionHandler) }
                }
                
            @unknown default:
                completionHandler(false)
            }
        }
    }
    
    private func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        DispatchQueue.main.async {
            
            let settingAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
               // completionHandler(false)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            })
            let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access." , preferredStyle: .alert )
            alert.addAction(settingAction)
            alert.addAction(cancelAction)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}


import Foundation

public struct PhoneContact {
    public  let firstName: String?
    public let lastName: String?
    public let companyName: String?
    public let nickname: String?
    public  let phoneNumbers: String
    public var fullname: String {
        return (firstName ?? "") + " " + (lastName ?? "")
         
     }
    public let thumbnailImageData: Data?
    
    public init(firstName: String?, lastName: String?, companyName: String?, nickname: String?, phoneNumbers: String, thumbnailImageData: Data?) {
        self.firstName = firstName
        self.lastName = lastName
        self.companyName = companyName
        self.nickname = nickname
        self.phoneNumbers = phoneNumbers
        self.thumbnailImageData = thumbnailImageData
    }
}

//class NumberValidationService {
//
//    private let phoneUtil:NBPhoneNumberUtil
//
//    init(phoneNumberUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()) {
//        self.phoneUtil = phoneNumberUtil
//    }
//
//    func format(number: String, countryCode: String, with format: NBEPhoneNumberFormat = .INTERNATIONAL) throws -> String? {
//            let currentCountryCode = countryCode
//            let number = try phoneUtil.parse(number, defaultRegion: currentCountryCode)
//            let formattedNumber = try phoneUtil.format(number, numberFormat: format)
//            let formattedUtilNumber = try phoneUtil.parse(formattedNumber, defaultRegion: currentCountryCode)
//            if phoneUtil.isValidNumber(formattedUtilNumber) {
//                return formattedNumber
//            }
//            return formattedNumber
//    }
//
//}
