//
//  DatePickerManger.swift
//  DrAlkhayatApp-IOS
//
//  Created by Esraa Masuad on 7/1/20.
//  Copyright © 2020 Esraa Masuad. All rights reserved.
//

import UIKit


enum PickerType : String {
    case date = "date"
    case time = "time"
}

protocol PickDateProtocol {
    func selectDate (_ pickerType: PickerType, completionBlock: @escaping (_ date: String,Date ) -> Void )
}

class DatePickerManager: PickDateProtocol {

    
    var currentVc:UIViewController!
    var selectDate: Date?
    var timeInterval: Double?
    var dateTimeStamp: Int?
    
    init(_ currentVc: UIViewController) {
        self.currentVc = currentVc
    }
    
    func selectDate(_ pickerType: PickerType, completionBlock: @escaping (String, Date) -> Void) {
         
        let message = "\n\n\n\n\n\n"
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.actionSheet)
        alert.isModalInPopover = true
        let datePicker: UIDatePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        let dateFormatter = DateFormatter()
        datePicker.frame = CGRect(x: 10, y: 10, width: self.currentVc.view.frame.width, height: 150)
         dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
       
        switch pickerType {
        case .time:
           // Language.setAppLanguage(language: "en")
//            datePicker.minimumDate = Calendar.current.date(byAdding: .hour, value: 0, to: Date())
//            datePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 0, to: Date())
            datePicker.datePickerMode = UIDatePicker.Mode.time
            dateFormatter.dateFormat = "HH:mm"
        case .date:
           // Language.setAppLanguage(language: "en")
            datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
            datePicker.minimumDate = Calendar.current.date(byAdding: .month, value: 0, to: Date())
            datePicker.datePickerMode = UIDatePicker.Mode.date
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        
        //Add the picker to the alert controller
        alert.view.addSubview(datePicker)
        let okAction = UIAlertAction(title: "Done".localized(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let selectedDate = dateFormatter.string(from: datePicker.date)
             // Language.setAppLanguage(language: "ar")
            completionBlock(selectedDate,datePicker.date)

        })
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
        //     Language.setAppLanguage(language: "ar")
        })
        alert.addAction(cancelAction)
        self.currentVc.present(alert, animated: true, completion:nil)
    }
}
