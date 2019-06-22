//
//  ContactDetailViewController.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 22/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    //MARK:- Properties
    
    @IBOutlet weak var profilePicture: AsyncImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var containerView: UIView!
    var contactInfo: ContactInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI() {
        self.changeNavigationTextColor()
        self.containerView.setGradientBackground(colorTop: .white, colorBottom: UIColor.init(red: 218/255, green: 245/255, blue: 239/255, alpha: 1))
        self.profilePicture.layer.borderColor = UIColor.white.cgColor
        //self.profilePicture.layer.cornerRadius = self.profilePicture.frame.width / 2
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
//        var view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//        view.backgroundColor = UIColor.yellow
//        var barButtonItem = UIBarButtonItem(customView: view)
//        self.navigationItem.rightBarButtonItem = barButtonItem
//        self.navigationController?.navigationItem.rightBarButtonItem = barButtonItem
//        self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 218/255, green: 245/255, blue: 239/255, alpha: 1)
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
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height / 2.0
    }
}

