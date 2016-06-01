//
//  MDNotificationView.swift
//
//  Created by Moritz Dietsche on 01.06.16.
//

import UIKit

class MDNotificationView: UIView {
    
    private var lastLocationY: CGFloat = 0
    private var translationY: CGFloat = 0
    
    private let parentWindow: UIWindow
    
    private let size: MDNotificationViewSize
    private let position: MDNotificationViewPosition

    var delegate: MDNotificationViewDelegate?
    
    init(view: UIView, size: MDNotificationViewSize, position: MDNotificationViewPosition) {
        self.size = size
        self.position = position
        
        var frame = CGRectZero
        
        guard let window = view.window else {
            fatalError()
        }
        
        self.parentWindow = window
        
        switch position {
        case .Top:
            frame = CGRectMake(window.frame.origin.x, window.frame.origin.y - size.rawValue, window.frame.width, size.rawValue)
        case .Bottom:
            frame = CGRectMake(window.frame.origin.x, window.frame.height, window.frame.width, size.rawValue)
        }
        
        super.init(frame: frame)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    convenience init(view: UIView) {
        self.init(view: view, size: .Compact, position: .Top)
    }
    
    convenience init(view: UIView, size: MDNotificationViewSize) {
        self.init(view: view, size: size, position: .Top)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        self.parentWindow.addSubview(self)

        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            switch self.position {
            case .Top:
                self.frame = CGRectMake(self.parentWindow.frame.origin.x, self.parentWindow.frame.origin.y, self.parentWindow.frame.width, self.size.rawValue)
            case .Bottom:
                self.frame = CGRectMake(self.parentWindow.frame.origin.x, self.parentWindow.frame.height - self.size.rawValue, self.parentWindow.frame.width, self.size.rawValue)
            }
            }, completion: { (completed) in
                if completed {

                }
        })
    }
    
    func hide() {
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseIn, animations: {
            switch self.position {
            case .Top:
                self.frame = CGRectMake(self.parentWindow.frame.origin.x, self.parentWindow.frame.origin.y - self.size.rawValue, self.parentWindow.frame.width, self.size.rawValue)
            case .Bottom:
                self.frame = CGRectMake(self.parentWindow.frame.origin.x, self.parentWindow.frame.height, self.parentWindow.frame.width, self.size.rawValue)
            }
            }, completion: { (completed) in
                if completed {

                }
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.lastLocationY = frame.origin.y
        self.translationY = 0
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        if let superview = self.superview {
            if .Ended == sender.state {
                if 0 < abs(self.translationY) {
                    self.hide()
                }
                else {
                    self.show()
                }
            }
            else {
                self.translationY = sender.translationInView(superview).y
                
                switch self.position {
                case .Top:
                    let newY = min(self.lastLocationY + translationY, 0)
                    self.frame = CGRectMake(self.frame.origin.x, newY, self.frame.width, self.size.rawValue)
                case .Bottom:
                    let newY = max(self.lastLocationY + translationY, self.parentWindow.frame.height - self.size.rawValue)
                    self.frame = CGRectMake(self.frame.origin.x, newY, self.frame.width, self.size.rawValue)
                }
            }
        }
    }
    
}
