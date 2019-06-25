//
//  ContactEditTableViewCell.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 24/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

enum ContactEditValues: Int {
    case first_Name = 0
    case last_Name = 1
    case mobile = 2
    case email = 3
}

class ContactEditTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var textFieldValue: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- Configure cell as per data
    func configure(details: Contactdetails, index: IndexPath, contactDetailsEditVC: ContactDetailEditViewController) {
        // Set textField Delegate =
        self.textFieldValue.delegate = contactDetailsEditVC
        self.textFieldValue.tag = 100
        switch index.row {
        case ContactEditValues.first_Name.rawValue:
            self.lblName.text = "First Name"
            self.textFieldValue.text = details.first_name
            
        case ContactEditValues.last_Name.rawValue:
            self.lblName.text = "Last Name"
            self.textFieldValue.text = details.last_name
            
        case ContactEditValues.mobile.rawValue:
            self.lblName.text = "mobile"
            self.textFieldValue.text = details.phone_number
            
        case ContactEditValues.email.rawValue:
            self.lblName.text = "email"
            self.textFieldValue.text = details.email
        default:
            self.textFieldValue.text = ""
        }
    }
}

