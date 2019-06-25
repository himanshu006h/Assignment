//
//  ViewController.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 22/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let cellIdentifier = "ContactTableCell"
        static let indexingIdentifier = "IndexingTableViewCell"
        static let cancel = "Cancel"
        static let blank = ""
    }
    //MARK:- Properties
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var indexingTable: UITableView!
    var conatctInformation: [ContactInfo]?
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H","I", "J", "K", "L","M", "N", "O", "P","Q", "R", "S", "T","U", "V", "W", "X", "Y", "Z"]
    var selectedSearchKey = "A"
    //refresh Table logic
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addrefreshControl()
        registerContactCell()
        loadContactDetails()
        // Do any additional setup after loading the view.
    }
    
    // drag table to refresh contact
    func addrefreshControl() {
        self.contactTableView.addSubview(self.refreshControl)
    }
    
    private func loadContactDetails(pullToRefresh: Bool = false) {
        if !pullToRefresh {
            startLoadingIndicator()
        }
        // get Data from service
        let assignmentVModel = AssignmentViewModel(conatactInfo: nil, conatctDelegate: self)
        assignmentVModel.fetchContactDetails()
    }
    
    func registerContactCell() {
        self.contactTableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        self.indexingTable.register(UINib(nibName: Constants.indexingIdentifier, bundle: nil), forCellReuseIdentifier: Constants.indexingIdentifier)
    }
    
    func startLoadingIndicator() {
        // start activity spinner
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        loadContactDetails(pullToRefresh: true)
    }
    
    func updateTableView() {
        self.refreshControl.endRefreshing()
        self.activityIndicator.stopAnimating()
        self.contactTableView.reloadData()
    }
    //Dummy functionality of Add Button
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let newDetailViewController = ContactDetailEditViewController.getViewController() else {
                return
        }
        
        // Set dependency
        newDetailViewController.isNewUser = true
        newDetailViewController.conatctInformation = Contactdetails(first_Name: "", last_name: "", phone_number: "", email: "", profile_pic: "", favorite: false, created_at: "", updated_at: "")
        self.present(newDetailViewController, animated: true, completion: nil)
    }
}

extension ViewController: ContactInformation {
    func updateContactDetails(contactDetails: Any?, error: Error?) {
        
        if error == nil {
            guard let contacts = contactDetails as? [ContactInfo] else {
                return
            }
            
            self.conatctInformation = contacts
            DispatchQueue.main.async{
                self.updateTableView()
            }
        } else if let erorrDiscription = error {
            DispatchQueue.main.async {
                self.updateTableView()
                let alertViewController = UIAlertController(title: Constants.blank, message: erorrDiscription.localizedDescription, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: Constants.cancel, style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
    
    func scrollToIndexPath() {
        guard let contacts = self.conatctInformation else {
            return
        }
        
        var rowCounter = 0
        for contact in contacts {
            if contact.first_name!.prefix(1) == self.selectedSearchKey {
                self.contactTableView.scrollToRow(at: IndexPath(row: rowCounter, section: 0), at: .top, animated: true)
            } else {
                rowCounter += 1
            }
        }
    }
}

