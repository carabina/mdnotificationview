//
//  ViewController.swift
//  MDNotificationViewDemo
//
//  Created by Moritz Dietsche on 01.06.16.
//

import UIKit

class ViewController: UIViewController, MDNotificationViewDelegate {
    
    @IBAction func showButtonTapped(_ sender: AnyObject) {
        
        let notificationView = MDNotificationView(view: self.view, size: .expanded)
        notificationView.backgroundColor = UIColor.red()
        notificationView.show()
        
    }

    @IBAction func showBottomButtonTapped(_ sender: AnyObject) {

        let notificationView = MDNotificationView(view: self.view, size: .compact, position: .bottom)
        notificationView.backgroundColor = UIColor.blue()
        notificationView.show()

    }
    
}
