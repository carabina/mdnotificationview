//
//  ViewController.swift
//  MDNotificationViewDemo
//
//  Created by Moritz Dietsche on 01.06.16.
//

import UIKit

class ViewController: UIViewController, MDNotificationViewDelegate {
    
    @IBAction func showButtonTapped(sender: AnyObject) {
        
        let notificationView = MDNotificationView(view: self.view, size: .Expanded)
        notificationView.backgroundColor = UIColor.redColor()
        notificationView.show()
        
    }

    @IBAction func showBottomButtonTapped(sender: AnyObject) {

        let notificationView = MDNotificationView(view: self.view, size: .Compact, position: .Bottom)
        notificationView.backgroundColor = UIColor.blueColor()
        notificationView.show()

    }
    
}
