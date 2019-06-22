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
        return self.conatctInformation?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ContactTableCell, let details = self.conatctInformation else {
            return UITableViewCell()
        }
            cell.configureCell(contactInfo: details[indexPath.row])
            return cell
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.conatctInformation?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! UITableViewCell
//        //cell.updateView(for: viewData, for: self.tableView)
//
//        return cell
//    }
    
}
