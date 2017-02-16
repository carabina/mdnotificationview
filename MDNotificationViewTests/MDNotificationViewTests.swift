//
//  MDNotificationTest.swift
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

class MDNotificationViewTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConvencienceInitOptionalPosition() {
        let notificationView = MDNotificationView(view: UIView())
        
        XCTAssertEqual(notificationView.frame.origin.y + notificationView.frame.size.height, 0)
    }

    func testConvencienceInitTopPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)))
        
        XCTAssertEqual(notificationView.frame.origin.y, -notificationView.frame.size.height)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width, UIScreen.main.bounds.width)
  
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)))
        
        XCTAssertEqual(notificationView2.frame.origin.y, -notificationView2.frame.size.height)
    }
    
    func testConvencienceInitBottomPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .bottom)
        
        XCTAssertEqual(notificationView.frame.origin.y,  UIScreen.main.bounds.height)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width,  UIScreen.main.bounds.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .bottom)
        
        XCTAssertEqual(notificationView2.frame.origin.y,  UIScreen.main.bounds.height)
    }

    func testShownTopPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .top)
        notificationView.show()
        sleep(1)
        
        XCTAssertEqual(notificationView.frame.origin.y, 0)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width,  UIScreen.main.bounds.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .top)
        notificationView2.show()
        sleep(1)
        
        XCTAssertEqual(notificationView2.frame.origin.y, 0)
    }
    
    func testShownBottomPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .bottom)
        notificationView.show()
        sleep(1)
        
        XCTAssertEqual(notificationView.frame.origin.y,  UIScreen.main.bounds.height - notificationView.frame.size.height)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width,  UIScreen.main.bounds.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .bottom)
        notificationView2.show()
        sleep(1)
        
        XCTAssertEqual(notificationView2.frame.origin.y,  UIScreen.main.bounds.height - notificationView2.frame.size.height)
    }
    
    func testHiddenTopPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .top)
        notificationView.show()
        sleep(1)
        notificationView.hide()
        sleep(1)
        
        XCTAssertEqual(notificationView.frame.origin.y
            + notificationView.frame.size.height, 0)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width,  UIScreen.main.bounds.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .top)
        notificationView2.show()
        sleep(1)
        notificationView2.hide()
        sleep(1)
        
        XCTAssertEqual(notificationView2.frame.origin.y + notificationView2.frame.size.height, 0)
    }
    
    func testHiddenBottomPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .bottom)
        notificationView.show()
        sleep(1)
        notificationView.hide()
        sleep(1)
      
        XCTAssertEqual(notificationView.frame.origin.y,  UIScreen.main.bounds.height)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width,  UIScreen.main.bounds.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .bottom)
        notificationView2.show()
        sleep(1)
        notificationView2.hide()
        sleep(1)
    
        XCTAssertEqual(notificationView2.frame.origin.y,  UIScreen.main.bounds.height)
    }

}
