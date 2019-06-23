//
//  ContactDetailsViewModel.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 23/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation

protocol ContactDetailsProtocol {
    func updateContactInformation(contactDetails: Any?, error: Error?)
}

struct ContactDetailsViewModel {
    //MARK:- Properties
    var conatactInfo : Contactdetails?
    let conatctDelegate: ContactDetailsProtocol?
    
    func fetchContactDetails(urlString: String) {
        // Fetch data from the API
        //ServiceType
        NetworkDataLoader().loadResult(urlString: urlString,serviceType: ServiceType.contactsDetails,completion: { result in
            switch result {
            case let .success(contactValues):
                self.conatctDelegate?.updateContactInformation(contactDetails: contactValues, error: nil)
                DispatchQueue.main.async {
                    
                }
                // We had handle the error more precisely rather then just printing to console.
            // The specific type of error can generate specific error for the user
            case let .failure(error) :
                print("")
                self.conatctDelegate?.updateContactInformation(contactDetails: nil, error: error)
            }
        })
    }
}
