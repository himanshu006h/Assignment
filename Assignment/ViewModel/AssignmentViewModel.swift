//
//  AssignmentViewModel.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 21/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation

protocol ContactInformation: class {
    func updateContactDetails(contactDetails: Any?, error: Error?)
}

struct AssignmentViewModel {
    //MARK:- Properties
    var conatactInfo : [ContactInfo]?
    weak var conatctDelegate: ContactInformation?
    
     func fetchContactDetails() {
        
        // Fetch data from the API
        NetworkDataLoader().loadResult { result in
            switch result {
            case let .success(feedInfo):
                self.conatctDelegate?.updateContactDetails(contactDetails: feedInfo, error: nil)
                DispatchQueue.main.async {

                }
                // We had handle the error more precisely rather then just printing to console.
            // The specific type of error can generate specific error for the user
            case let .failure(error) :
                self.conatctDelegate?.updateContactDetails(contactDetails: nil, error: error)
            }
        }
    }
}
