//
//  ViewController.swift
//  MDNotificationView
//
//  Copyright (c) 2017 Moritz Dietsche
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import MDNotificationView

/// The view controller of the example app.
class ViewController: UIViewController, MDNotificationViewDelegate {
    
    var newMessageNotificationView: MDNotificationView?
    var bottomNotificationView: MDNotificationView?
    var progressNotificationViews = [MDNotificationView]()
    
    var buttonLayoutView: MDNotificationCompactButtonLayoutView?
    var buttonNotificationView: MDNotificationView?
    
    @IBAction func showButtonTapped(_ sender: Any) {
        if let newMessageNotificationView = self.newMessageNotificationView {
            newMessageNotificationView.hide()
        }
        
        let view = MDNotificationExpandedImageLayoutView()
        view.imageView.image = UIImage(named: "Face")
        view.titleLabel.text = "The title"
        view.textLabel.text = "This view hides automatically after 5 seconds.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        
        self.newMessageNotificationView = MDNotificationView(view: view)
        if let newMessageNotificationView = self.newMessageNotificationView {
            newMessageNotificationView.delegate = self
            newMessageNotificationView.backgroundColor = UIColor(white: 1, alpha: 0.9)
            newMessageNotificationView.show()
        }
    }
    
    @IBAction func showBottomButtonTapped(_ sender: Any) {
        if let bottomNotificationView = self.bottomNotificationView {
            bottomNotificationView.hide()
            self.bottomNotificationView = nil
            
            (sender as? UIButton)?.setTitle("CompactLayoutView", for: .normal)
        } else {
            let view = MDNotificationCompactLayoutView()
            view.textLabel.text = "This view does not hide automatically. Swipe it to the bottom or click the button to hide it."
            view.textLabel.textColor = UIColor(white: 0.9, alpha: 1)
            
            let notificationView = MDNotificationView(view: view, position: .bottom)
            self.bottomNotificationView = notificationView
            notificationView.backgroundColor = UIColor(white: 0, alpha: 0.8)
            notificationView.delegate = self
            notificationView.show()
            
            (sender as? UIButton)?.setTitle("Hide CompactLayoutView", for: .normal)
        }
    }
    
    @IBAction func customButtonTapped(_ sender: Any) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomView", bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        
        if 0 < views.count,
            let view = views[0] as? UIView {
            
            view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            
            let notificationView = MDNotificationView(view: view, position: .bottom)
            self.progressNotificationViews.append(notificationView)
            notificationView.delegate = self
            notificationView.show()
        }
    }
    
    @IBAction func buttonButtonTapped(_ sender: Any) {
        let view = MDNotificationCompactButtonLayoutView()
        view.textLabel.text = "Click me."
        view.button.addTarget(self, action: #selector(buttonViewButtonTapped), for: .touchUpInside)
        self.buttonLayoutView = view
        
        let notificationView = MDNotificationView(view: view, position: .bottom)
        notificationView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.buttonNotificationView = notificationView
        notificationView.show()
    }
    
    @IBAction func buttonViewButtonTapped(_ sender: Any) {
        if let buttonNotificationView = self.buttonNotificationView {
            if let buttonLayoutView = self.buttonLayoutView {
                buttonLayoutView.textLabel.text = "Thank you!"
                buttonLayoutView.button.isUserInteractionEnabled = false
                buttonLayoutView.button.isEnabled = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                buttonNotificationView.hide()
            }
        }
    }
    
    // MARK: Notification View Delegate
    
    func didTap(notificationView: MDNotificationView) {
        let currentBackgroundColor = notificationView.backgroundColor
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            notificationView.backgroundColor = UIColor.white
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                notificationView.backgroundColor = currentBackgroundColor
            }, completion: nil)
        }
    }
    
    func notificationDidShow(notificationView: MDNotificationView) {
        if notificationView == self.newMessageNotificationView {
            // Hide the notification view automatically after 5 seconds.
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                notificationView.hide()
            }
        } else if self.progressNotificationViews.contains(notificationView) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                notificationView.hide()
            }
        }
    }
    
    func notificationDidHide(notificationView: MDNotificationView) {
        if self.progressNotificationViews.contains(notificationView) {
            self.progressNotificationViews.remove(at: progressNotificationViews.index(of: notificationView)!)
        }
    }
    
}
