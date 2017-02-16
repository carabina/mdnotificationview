//
//  MDNotificationViewDelegateTests.swift
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

import XCTest
@testable import MDNotificationView

class MDNotificationViewDelegateTests: XCTestCase, MDNotificationViewDelegate {
    
    var expectation: XCTestExpectation?
    var notificationView: MDNotificationView?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        self.expectation = nil
        self.notificationView = nil
        
        super.tearDown()
    }
    
    func testTap() {
        self.expectation = expectation(description: "handle tap")

        self.notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)))
        self.notificationView?.delegate = self
        self.notificationView?.show()
        self.notificationView?.handleTap(UITapGestureRecognizer(target: nil, action: nil))
        
        waitForExpectations(timeout: 2.0)
    }
    
    func testDidShow() {
        self.expectation = expectation(description: "did show")
        
        self.notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)))
        self.notificationView?.delegate = self
        self.notificationView?.show()
        
        waitForExpectations(timeout: 2.0)
    }
    
    func testDidHide() {
        self.expectation = expectation(description: "did hide")
        
        self.notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)))
        self.notificationView?.delegate = self
        self.notificationView?.show()
        self.notificationView?.hide()
        
        waitForExpectations(timeout: 10.0)
    }
    
    // MARK: - Notification View Delegate
    
    func didTap(notificationView: MDNotificationView) {
        if let expectationDescription = self.expectation?.description,
            "handle tap" == expectationDescription {
            XCTAssertEqual(self.notificationView, notificationView)
            self.expectation?.fulfill()
        }
    }
    
    func notificationDidShow(notificationView: MDNotificationView) {
        if let expectationDescription = self.expectation?.description,
            "did show" == expectationDescription {
            XCTAssertEqual(self.notificationView, notificationView)
            self.expectation?.fulfill()
        }
    }
    
    func notificationDidHide(notificationView: MDNotificationView) {
        if let expectationDescription = self.expectation?.description,
            "did hide" == expectationDescription {
            XCTAssertEqual(self.notificationView, notificationView)
            self.expectation?.fulfill()
        }
    }
    
}
