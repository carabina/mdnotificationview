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
    
    /// Used to prevent layouting of subviews during an animation.
    private var isShowingAnimation: Bool = false
    
    /// Indicates if a notification view appears from the top or the bottom of the screen.
    private var position: MDNotificationViewPosition!
    
    /// The view contained inside the notification view. The position is ajusted when
    /// when shown from the top to prevent it from being by the status bar.
    var view: UIView!

    /// The delegate is being notified when the notification has been shown, hidden or tapped.
    public var delegate: MDNotificationViewDelegate?
    
    /// Create a new notification view by passing an arbitrary `UIView`.
    ///
    /// - parameter view:        The view to be shown inside the notification view.
    /// - parameter position:    The position where the notification should appear. `.top` by default.
    public convenience init(view: UIView, position: MDNotificationViewPosition = .top) {
        var frame = CGRect.zero
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        switch position {
        case .top:
            frame = CGRect(x: 0, y: -view.frame.height - statusBarHeight, width: UIScreen.main.bounds.width, height: view.frame.height + statusBarHeight)
        case .bottom:
            frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: view.frame.height)
        }
        
        self.init(frame: frame)

        self.position = position
        self.view = view

        switch position {
        case .top:
            self.view.frame = CGRect(x: 0, y: statusBarHeight, width: self.frame.width, height: self.frame.height)
        case .bottom:
            self.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: view.frame.height)
        }
        
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth]

        self.addSubview(self.view)
    }
    
    /// Initializes the view with the frame as calulated in the convenience initializer.
    ///
    /// - parameter frame:       The frame just above or below the visible area of the screen.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth]

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// **Loading from storyboards is not supported.**
    required public init?(coder aDecoder: NSCoder) {
        fatalError("MDNotificationView cannot be instantiated from NIB.")
    }
    
    /// Recalculates the view frame. Will not recalculate the view frame if it is called during an
    /// animation or if the user is simply panning the view.
    override public func layoutSubviews() {
        super.layoutSubviews()

        // Prevent unneccessary redraw if the user is panning the view.
        if 0 == translationY,
            // Prevent "hiccups" during the show/hide animations.
            !self.isShowingAnimation {
            switch self.position! {
            case .top:
                self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
            case .bottom:
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.view.frame.height, width: UIScreen.main.bounds.size.width, height: self.view.frame.height)
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
    
    /// Slide in the notification view.
    /// Notify the delegate when the notification view has appeared entirely.
    public func show() {
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addSubview(self)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.isShowingAnimation = true
            
            switch self.position! {
            case .top:
                self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
            case .bottom:
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.view.frame.height, width: UIScreen.main.bounds.size.width, height: self.view.frame.height)
            }
        }, completion: {(_) in
            self.isShowingAnimation = false
            
            if let delegate = self.delegate {
                delegate.notificationDidShow(notificationView: self)
            }
        })
    }
    
    /// Slide out the notification view.
    /// Notify the delegate when the notification view has disappeared entirely.
    public func hide() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.isShowingAnimation = true
            
            switch self.position! {
            case .top:
                self.frame = CGRect(x: 0, y: 0 - self.view.frame.height - UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.size.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
            case .bottom:
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: self.view.frame.height)
            }
        }, completion: { (_) in
            self.isShowingAnimation = false
            
            self.removeFromSuperview()
            
            if let delegate = self.delegate {
                delegate.notificationDidShow(notificationView: self)
            }
        })
    }
    
    /// Start tracking the last y coordinate of the view.
    /// - parameter touches:        A set of UITouch instances that represent the touches for the starting
    ///                             phase of the event, which is represented by event.
    /// - parameter event:          The event to which the touches belong.
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.lastLocationY = frame.origin.y
        self.translationY = 0
    }

    /// Move the view up or down according to the pan gesture.
    /// Hide the view if the gesture stops.
    /// - parameter sender:         The sender of the pan gesture.
   func handlePan(_ sender: UIPanGestureRecognizer) {
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
                self.frame = CGRect(x: self.frame.origin.x, y: newY, width: self.frame.width, height: self.view.frame.height + UIApplication.shared.statusBarFrame.height)
            case .bottom:
                let newY = max(self.lastLocationY + translationY, UIScreen.main.bounds.size.height - self.view.frame.height)
                self.frame = CGRect(x: self.frame.origin.x, y: newY, width: self.frame.width, height: self.view.frame.height)
            }
        }
    }
    
    /// Notify the delegate that the user has tapped the notification.
    /// - parameter sender:         The sender of the tap gesture.
    func handleTap(_ sender: UITapGestureRecognizer) {
        if let delegate = self.delegate {
            delegate.didTap(notificationView: self)
        }
    }
    
}
