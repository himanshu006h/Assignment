//
//  ViewController+TableDataSource.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 22/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        if tableView == self.contactTableView {
            returnValue = self.conatctInformation?.count ?? 0
        } else if tableView == self.indexingTable {
            returnValue = self.letters.count
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.contactTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ContactTableCell, let details = self.conatctInformation else {
                return UITableViewCell()
            }
            cell.configureCell(contactInfo: details[indexPath.row])
            return cell
            
        } else if tableView == self.indexingTable {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.indexingIdentifier, for: indexPath) as? IndexingTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(charValue: self.letters[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.indexingTable {
            self.selectedSearchKey = self.letters[indexPath.row]
            self.scrollToIndexPath()
            
        } else if tableView == self.contactTableView {
        guard let detailsViewController = ContactDetailViewController.getViewController(),
            let details = self.conatctInformation else {
                return
        }
        
        // Set dependency
        detailsViewController.contactInfo = details[indexPath.row]
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
}
