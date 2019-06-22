//
//  ViewController.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 22/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContactDetails()
        // Do any additional setup after loading the view.
    }

    private func loadContactDetails() {
             // get Data from service
        let assignmentVModel = AssignmentViewModel(conatactInfo: nil, conatctDelegate: self)
        assignmentVModel.fetchContactDetails()
    }
}

extension ViewController: contactInformation {
    func updateContactDetails(contactDetails: [ContactInfo]?, error: Error?) {
        
    }
}

