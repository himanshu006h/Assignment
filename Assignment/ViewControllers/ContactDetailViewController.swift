//
//  ContactDetailViewController.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 22/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    //MARK:- Constants
    struct Constants{
        static let contactDetailCellId = "ContactDetailCell"
        static let cancel = "Cancel"
        static let blank = ""
    }
    
    //MARK:- Properties
    @IBOutlet weak var profilePicture: AsyncImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableViewDetails: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var contactInfo: ContactInfo?
    var conatctInformation: Contactdetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.registerDetailCell()
        self.loadContactDetails()
    }
    
    func setUpUI() {
        self.changeNavigationTextColor()
        self.containerView.setGradientBackground(colorTop: .white, colorBottom: UIColor.init(red: 218/255, green: 245/255, blue: 239/255, alpha: 1))
        self.profilePicture.layer.borderColor = UIColor.white.cgColor
        // Set all values
        guard let details = self.contactInfo,
            let picURL = details.profile_pic,
            let firstName = details.first_name,
            let lastName = details.first_name else {
                return
        }
        
        
        self.userName.text = firstName + " " + lastName
        self.profilePicture.loadImage(urlString: picURL)
    }
    
    func changeNavigationTextColor() {
        let editButton = UIButton(type: UIButton.ButtonType.custom)
        editButton.setTitleColor(UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1), for: .normal)
        editButton.setTitle("Edit", for: .normal)
        editButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        editButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        let barButtonItem = UIBarButtonItem(customView: editButton)
        self.navigationItem.rightBarButtonItem = barButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1)
    }
    
    static func getViewController() -> ContactDetailViewController? {
        //Main
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController else {
            return nil
        }
        
        return viewController
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        //We can Add pre define functionality of Call/Message/Email
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height / 2.0
    }
    
    func registerDetailCell() {
        self.tableViewDetails.register(UINib(nibName: Constants.contactDetailCellId, bundle: nil), forCellReuseIdentifier: Constants.contactDetailCellId)
    }
    
    func updateTableView() {
        self.activityIndicator.stopAnimating()
        self.tableViewDetails.reloadData()
        self.tableViewDetails.isHidden = false
    }
    
    func startLoadingIndicator() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func loadContactDetails() {
        self.startLoadingIndicator()
        // get Data from service
        let detailsVModel = ContactDetailsViewModel(conatactInfo: nil, conatctDelegate: self)
        guard let urlString = self.contactInfo?.url else {
            return
        }
        
        detailsVModel.fetchContactDetails(urlString: urlString)
    }
}


extension ContactDetailViewController: ContactDetailsProtocol {
    func updateContactInformation(contactDetails: Any?, error: Error?) {
        if error == nil {
            guard let details = contactDetails as? Contactdetails else { return }
            self.conatctInformation = details
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

