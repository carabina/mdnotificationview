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
        
        var frame = CGRect.zero
        
        guard let window = view.window else {
            fatalError()
        }
        
        self.parentWindow = window
        
        switch position {
        case .top:
            frame = CGRect(x: window.frame.origin.x, y: window.frame.origin.y - size.rawValue, width: window.frame.width, height: size.rawValue)
        case .bottom:
            frame = CGRect(x: window.frame.origin.x, y: window.frame.height, width: window.frame.width, height: size.rawValue)
        }
        
        super.init(frame: frame)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    convenience init(view: UIView) {
        self.init(view: view, size: .compact, position: .top)
    }
    
    convenience init(view: UIView, size: MDNotificationViewSize) {
        self.init(view: view, size: size, position: .top)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        self.parentWindow.addSubview(self)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            switch self.position {
            case .top:
                self.frame = CGRect(x: self.parentWindow.frame.origin.x, y: self.parentWindow.frame.origin.y, width: self.parentWindow.frame.width, height: self.size.rawValue)
            case .bottom:
                self.frame = CGRect(x: self.parentWindow.frame.origin.x, y: self.parentWindow.frame.height - self.size.rawValue, width: self.parentWindow.frame.width, height: self.size.rawValue)
            }
            }, completion: { (completed) in
                if completed {

                }
        })
    }
    
    func hide() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            switch self.position {
            case .top:
                self.frame = CGRect(x: self.parentWindow.frame.origin.x, y: self.parentWindow.frame.origin.y - self.size.rawValue, width: self.parentWindow.frame.width, height: self.size.rawValue)
            case .bottom:
                self.frame = CGRect(x: self.parentWindow.frame.origin.x, y: self.parentWindow.frame.height, width: self.parentWindow.frame.width, height: self.size.rawValue)
            }
            }, completion: { (completed) in
                if completed {

                }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.lastLocationY = frame.origin.y
        self.translationY = 0
    }
    
    func handlePan(_ sender: UIPanGestureRecognizer) {
        if let superview = self.superview {
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
                
                switch self.position {
                case .top:
                    let newY = min(self.lastLocationY + translationY, 0)
                    self.frame = CGRect(x: self.frame.origin.x, y: newY, width: self.frame.width, height: self.size.rawValue)
                case .bottom:
                    let newY = max(self.lastLocationY + translationY, self.parentWindow.frame.height - self.size.rawValue)
                    self.frame = CGRect(x: self.frame.origin.x, y: newY, width: self.frame.width, height: self.size.rawValue)
                }
            }
        }
    }
    
}
