//
//  ContactDetailViewController+TableDataSource.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 23/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation
import UIKit


extension ContactDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Currenty we have two fiels only
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.contactDetailCellId, for: indexPath) as? ContactDetailCell, let details = self.conatctInformation else {
            return UITableViewCell()
        }
        cell.configure(details: details, index: indexPath)
        return cell
    }
}
