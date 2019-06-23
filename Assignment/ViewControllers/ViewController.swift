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
        static let cancel = "Cancel"
        static let blank = ""
    }
    //MARK:- Properties
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var conatctInformation: [ContactInfo]?
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
        guard let detailsViewController = ContactDetailViewController.getViewController(),
            let details = self.conatctInformation else {
                return
        }
        
        // Set dependency
        detailsViewController.contactInfo = details.first
        self.navigationController?.pushViewController(detailsViewController, animated: true)
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
}

