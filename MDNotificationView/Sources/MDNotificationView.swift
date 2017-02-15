//
//  MDNotificationView.swift
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

/// Notification views can contain predefined layout views or custom views. They
/// are presented from the top or the bottom of the screen, overlapping the rest
/// of the app.
public class MDNotificationView: UIView {
    
    /// Contains the y coordinate of the view during the previous panning callback.
    /// Used to determine the direction of the panning movement.
    private var lastLocationY: CGFloat = 0

    /// Contains the current y offset to the visible position.
    private var translationY: CGFloat = 0
    private var isShowingAnimation: Bool = false
    
    private var position: MDNotificationViewPosition!
    
    var view: UIView!
    public var delegate: MDNotificationViewDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    public convenience init(view: UIView, position: MDNotificationViewPosition = .top) {
        var frame = CGRect.zero
        
        if let keyWindow = UIApplication.shared.keyWindow {
            switch position {
            case .top:
                frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.origin.y - view.frame.height - UIApplication.shared.statusBarFrame.height, width: keyWindow.frame.width, height: view.frame.height + UIApplication.shared.statusBarFrame.height)
            case .bottom:
                frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.height, width: keyWindow.frame.width, height: view.frame.height)
            }
        }
        
        self.init(frame: frame)

        self.position = position
        self.view = view

        switch position {
        case .top:
            self.view.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: frame.width, height: view.frame.height)
        case .bottom:
            self.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: view.frame.height)
        }
        
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth]

        self.addSubview(self.view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth]

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("MDNotificationView cannot be instantiated from NIB.")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        if let keyWindow = UIApplication.shared.keyWindow,
            // Prevent unneccessary redraw if the user is panning the view.
            0 == translationY,
            // Prevent "hiccups" during the show/hide animations.
            !self.isShowingAnimation {
            switch self.position! {
            case .top:
                self.frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.origin.y, width: keyWindow.frame.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
            case .bottom:
                self.frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.height - self.view.frame.height, width: keyWindow.frame.width, height: self.view.frame.height)
            }
        
            for subview in self.subviews {
                switch self.position! {
                case .top:
                    subview.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: frame.width, height: view.frame.height)
                case .bottom:
                    subview.frame = CGRect(x: 0, y: 0, width: frame.width, height: view.frame.height)
                }
            }
        }
    }
    
    public func show() {
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addSubview(self)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.isShowingAnimation = true
                
                switch self.position! {
                case .top:
                    self.frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.origin.y, width: keyWindow.frame.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
                case .bottom:
                    self.frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.height - self.view.frame.height, width: keyWindow.frame.width, height: self.view.frame.height)
                }
            }, completion: {(_) in
                self.isShowingAnimation = false
                
                if let delegate = self.delegate {
                    delegate.notificationDidShow(notificationView: self)
                }
            })
        }
    }
    
    public func hide() {
        if let keyWindow = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                self.isShowingAnimation = true

                switch self.position! {
                case .top:
                    self.frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.origin.y - self.view.frame.height - UIApplication.shared.statusBarFrame.height, width: keyWindow.frame.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
                case .bottom:
                    self.frame = CGRect(x: keyWindow.frame.origin.x, y: keyWindow.frame.height, width: keyWindow.frame.width, height: self.view.frame.height)
                }
            }, completion: { (_) in
                self.isShowingAnimation = false

                self.removeFromSuperview()
 
                if let delegate = self.delegate {
                    delegate.notificationDidShow(notificationView: self)
                }
            })
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.lastLocationY = frame.origin.y
        self.translationY = 0
    }
    
    func handlePan(_ sender: UIPanGestureRecognizer) {
        if let keyWindow = UIApplication.shared.keyWindow {
            if .ended == sender.state {
                if 0 < abs(self.translationY) {
                    self.hide()
                }
                else {
                    self.show()
                }
            }
            else {
                self.translationY = sender.translation(in: superview).y
                
                switch self.position! {
                case .top:
                    let newY = min(self.lastLocationY + translationY, 0)
                    print(newY)
                    self.frame = CGRect(x: self.frame.origin.x, y: newY, width: self.frame.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
                case .bottom:
                    let newY = max(self.lastLocationY + translationY, keyWindow.frame.height - self.view.frame.height)
                    self.frame = CGRect(x: self.frame.origin.x, y: newY, width: self.frame.width, height: self.view.frame.height)
                }
            }
        }
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        if let delegate = self.delegate {
            delegate.didTap(notificationView: self)
        }
    }
    
}
