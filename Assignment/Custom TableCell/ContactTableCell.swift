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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   public func configureCell(contactInfo: ContactInfo?) {
   
    guard let details = contactInfo,
        let profileImage = details.profile_pic,
        let isFavorite = details.favorite else {
        return
    }
    
    if isFavorite {
        self.imageViewFav.image = UIImage.init(named: Constants.favoriteImage)
    }
    
    self.contactName.text = details.first_name
    self.imageViewIcon.loadImage(urlString: profileImage)
    }
    
}
