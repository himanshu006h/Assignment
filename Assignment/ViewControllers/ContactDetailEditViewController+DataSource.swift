//
//  ContactDetailEditViewController+DataSource.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 24/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation
import UIKit

extension ContactDetailEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Currenty we have four fiels only
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.contactEditCellId, for: indexPath) as? ContactEditTableViewCell, let details = self.conatctInformation else {
            return UITableViewCell()
        }
        cell.configure(details: details, index: indexPath, contactDetailsEditVC: self)
        return cell
    }
}
