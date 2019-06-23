//
//  ContactTableCell.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 22/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ContactTableCell: UITableViewCell {
    
    //MARK:- Properties
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var imageViewFav: UIImageView!
    @IBOutlet weak var imageViewIcon: AsyncImageView!
    
    struct Constants {
        static let favoriteImage = "home_favourite"
        static let favoriteImageUnselected = "favourite_button"
    }
    
    //MARK:- Configure cell as per data
    public func configureCell(contactInfo: ContactInfo?) {
        
        guard let details = contactInfo,
            let profileImage = details.profile_pic,
            let isFavorite = details.favorite,
            let firstName = details.first_name,
            let lastName = details.last_name else {
                return
        }
        
        if isFavorite == true {
            self.imageViewFav.image = UIImage.init(named: Constants.favoriteImage)
        } else {
            self.imageViewFav.image = UIImage.init(named: Constants.favoriteImageUnselected)
        }
        
        
        self.contactName.text = firstName + " " + lastName
        self.imageViewIcon.loadImage(urlString: profileImage)
    }
    
}
