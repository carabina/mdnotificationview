//
//  MDNotificationDelegate.swift
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

import Foundation

/// Implement these methods and register as the delegate of a notification to be
/// notified of events.
public protocol MDNotificationViewDelegate {
    
    /// Will be called when the notification has been tapped by the user.
    ///
    /// - parameter notificationView:   The notification that has been tapped.
    func didTap(notificationView: MDNotificationView)
    
    /// Will be called when the notification view has appeared entirely.
    ///
    /// - parameter notificationView:   The notification that has been shown.
    func notificationDidShow(notificationView: MDNotificationView)
    
    /// Will be called when the notification view has disappeared entirely.
    ///
    /// - parameter notificationView:   The notification that has been hidden.
    func notificationDidHide(notificationView: MDNotificationView)

}
