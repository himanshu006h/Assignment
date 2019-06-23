//
//  ContactDetailCell.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 23/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

enum ContactValues: Int {
    case mobile = 0
    case email = 1
}

class ContactDetailCell: UITableViewCell {

    @IBOutlet private weak var lblFieldName: UILabel!
    @IBOutlet private weak var lblFieldValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(details: Contactdetails, index: IndexPath) {
        switch index.row {
        case ContactValues.mobile.rawValue:
            self.lblFieldName.text = "mobile"
            self.lblFieldValue.text = details.phone_number

        case ContactValues.email.rawValue:
            self.lblFieldName.text = "email"
            self.lblFieldValue.text = details.email
        default:
            self.lblFieldName.text = ""
        }
    }
    
}
