//
//  ContactDetailEditViewController+TextField.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 24/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Keyboard Handling
extension ContactDetailEditViewController {
    
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ContactDetailEditViewController.keyboardWillChange(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    func unbindToKeyboard() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let deltaY =  curFrame.height
        let screenSize = UIScreen.main.bounds

        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            //Hard code value will remove on logic
            if screenSize.height < 700 {
                self.containerViewBottom.constant += abs(deltaY)
            } else {
                self.containerViewBottom.constant  = 100
            }
        })
    }
}

extension ContactDetailEditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.containerViewBottom.constant = 0
        return true
    }
}
