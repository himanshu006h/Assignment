//
//  IndexingTableViewCell.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 25/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class IndexingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblChar: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(charValue: String) {
        self.lblChar.text = charValue
    }
}
