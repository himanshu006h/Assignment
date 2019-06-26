//
//  ContactDetailsEditViewModel.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 25/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation

enum TextFieldValues: Int {
    case first_name = 0
    case last_name = 1
    case phone_number = 2
    case email = 3
}

protocol ContactDetailsEditProtocol: class {
    func editedContactInformation(contactDetails: Any?, error: Error?)
}

struct ContactDetailsEditViewModel {
    //MARK:- Properties
    var conatactInfo : Contactdetails?
    weak var editDelegate: ContactDetailsEditProtocol?
    let dateFormat = "yyyy-MM-ddTHH.mm.ss.SSSZ"
    let imageURl = "/images/missing.png"
    
    func fetchContactDetails(urlString: String, conatctInformation: Contactdetails, textValues: [String], isNewUser: Bool) {
        // Fetch data from the API
        //ServiceType
        let serviceType = isNewUser == true ? ServiceType.addDetails :ServiceType.editDetails
        NetworkDataLoader().loadResult(urlString: urlString,serviceType: serviceType, bodyPram: getRequestDict(conatctInformation: conatctInformation, textValues: textValues, isNewUser: isNewUser) , completion: { result in
            switch result {
            case let .success(contactValues):
                self.editDelegate?.editedContactInformation(contactDetails: contactValues, error: nil)
                DispatchQueue.main.async {
                    
                }
                // We had handle the error more precisely rather then just printing to console.
            // The specific type of error can generate specific error for the user
            case let .failure(error) :
                self.editDelegate?.editedContactInformation(contactDetails: nil, error: error)
            }
        })
    }
    
    func getRequestDict(conatctInformation: Contactdetails, textValues: [String], isNewUser: Bool) -> Dictionary<String, Any> {
        
        var requestDict = Dictionary<String, Any>()
        for (index, value) in textValues.enumerated() {
            switch index {
            case TextFieldValues.first_name.rawValue:
                requestDict["first_name"] = value
            case TextFieldValues.last_name.rawValue:
                requestDict["last_name"] = value
            case TextFieldValues.phone_number.rawValue:
                requestDict["phone_number"] = value
            case TextFieldValues.email.rawValue:
                requestDict["email"] = value
            default:
                requestDict["email"] = value
            }
        }

        requestDict["profile_pic"] = isNewUser == true ? imageURl : conatctInformation.profile_pic
        requestDict["favorite"] = false
        requestDict["created_at"] = isNewUser == true ? self.getCurrentDateString() : conatctInformation.created_at
        requestDict["updated_at"] = self.getCurrentDateString()

        return requestDict
    }
    
    func getCurrentDateString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = dateFormat
        return dateFormatterGet.string(from: Date())
    }
}
