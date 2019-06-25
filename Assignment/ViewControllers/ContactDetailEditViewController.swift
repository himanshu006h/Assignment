//
//  ContactDetailEditViewController.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 24/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ContactDetailEditViewController: UIViewController {
    
    @IBOutlet weak var imageViewProfile: AsyncImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var doneButton: UIButton!
    var conatctInformation: Contactdetails?
    var onEditDismiss: ((Contactdetails) -> Void)?
    var isNewUser = false
    
    //MARK:- Constants
    struct Constants{
        static let contactEditCellId = "ContactEditTableViewCell"
        static let cancel = "Cancel"
        static let blank = ""
        static let urlPUT = "http://gojek-contacts-app.herokuapp.com/contacts/"
        static let urlPost = "http://gojek-contacts-app.herokuapp.com/contacts.json"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.registerDetailCell()
        self.bindToKeyboard()
    }
    
    
    func setUpUI() {
        self.containerView.setGradientBackground(colorTop: .white, colorBottom: UIColor.init(red: 218/255, green: 245/255, blue: 239/255, alpha: 1))
        self.imageViewProfile.layer.borderColor = UIColor.white.cgColor
    }
    
    static func getViewController() -> ContactDetailEditViewController? {
        //Main
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailEditViewController") as? ContactDetailEditViewController else {
            return nil
        }
        
        return viewController
    }
    
    @IBAction func editProfilePicTapped(_ sender: Any) {
        
    }
    
    func registerDetailCell() {
        self.tableView.register(UINib(nibName: Constants.contactEditCellId, bundle: nil), forCellReuseIdentifier: Constants.contactEditCellId)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.unbindToKeyboard()
    }
    
    func getTextFieldDict() -> [String] {
        var textFieldsValue = [String]()
        for cell in tableView.subviews {
            if let textFieldValue = cell.viewWithTag(100) as? UITextField,
                let textValue = textFieldValue.text {
                textFieldsValue.append(textValue)
            }
        }
        
        return textFieldsValue.reversed()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        DispatchQueue.main.async{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // PUT Service call for update
        let editVModel = ContactDetailsEditViewModel(conatactInfo: nil, editDelegate: self)
        guard let contactID = self.conatctInformation?.id,
            let contactInfo = self.conatctInformation else {
                return
                
        }
        
        var editOrNewUrl: String
        if isNewUser == false {
            editOrNewUrl = Constants.urlPUT + String(contactID) + ".json"
        } else {
            editOrNewUrl = Constants.urlPost
        }
        // Start Indicator
        self.startLoadingIndicator()
        editVModel.fetchContactDetails(urlString: editOrNewUrl, conatctInformation: contactInfo, textValues: getTextFieldDict(), isNewUser: self.isNewUser)
    }
    
    func startLoadingIndicator() {
        DispatchQueue.main.async{
            self.doneButton.isEnabled = false
        }
        
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopLoadingIndicator() {
        DispatchQueue.main.async{
            self.doneButton.isEnabled = true
            self.activityIndicator.stopAnimating()
        }
    }
}

// Back Event handling for edit and Add functionality
extension ContactDetailEditViewController: ContactDetailsEditProtocol {
    func editedContactInformation(contactDetails: Any?, error: Error?) {
        // Stop Indicator
        self.stopLoadingIndicator()
        if error == nil {
            guard let details = contactDetails as? Contactdetails,
                let handler = self.onEditDismiss else {
                    self.dismiss(animated: true, completion: nil)
                    return
            }
            
            self.conatctInformation = details
            DispatchQueue.main.async{
                self.dismiss(animated: true, completion: {
                    handler(details)
                })
            }
        } else if let erorrDiscription = error {
            DispatchQueue.main.async {
                let alertViewController = UIAlertController(title: Constants.blank, message: erorrDiscription.localizedDescription, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: Constants.cancel, style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
}


