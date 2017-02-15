//
//  MDNotificationTest.swift
//  MDNotificationView
//
//  Created by Moritz Dietsche on 14.02.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
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
        
        XCTAssertEqual(notificationView.frame.origin.y
            + notificationView.frame.size.height, 0)
    }

    func testConvencienceInitTopPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)))
        
        XCTAssertEqual(notificationView.frame.origin.y
            + notificationView.frame.size.height, 0)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width, UIApplication.shared.keyWindow!.frame.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)))
        
        XCTAssertEqual(notificationView2.frame.origin.y + notificationView2.frame.size.height, 0)
    }
    
    func testConvencienceInitBottomPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .bottom)
        
        XCTAssertEqual(notificationView.frame.origin.y, UIApplication.shared.keyWindow!.frame.height)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width, UIApplication.shared.keyWindow!.frame.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .bottom)
        
        XCTAssertEqual(notificationView2.frame.origin.y, UIApplication.shared.keyWindow!.frame.height)
    }

    func testShownTopPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .top)
        notificationView.show()
        sleep(1)
        
        XCTAssertEqual(notificationView.frame.origin.y, 0)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width, UIApplication.shared.keyWindow!.frame.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .top)
        notificationView2.show()
        sleep(1)
        
        XCTAssertEqual(notificationView2.frame.origin.y, 0)
    }
    
    func testShownBottomPosition() {
        let notificationView = MDNotificationView(view: UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50)), position: .bottom)
        notificationView.show()
        sleep(1)
        
        XCTAssertEqual(notificationView.frame.origin.y, UIApplication.shared.keyWindow!.frame.height - notificationView.frame.size.height)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width, UIApplication.shared.keyWindow!.frame.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .bottom)
        notificationView2.show()
        sleep(1)
        
        XCTAssertEqual(notificationView2.frame.origin.y, UIApplication.shared.keyWindow!.frame.height - notificationView2.frame.size.height)
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
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width, UIApplication.shared.keyWindow!.frame.width)
        
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
      
        XCTAssertEqual(notificationView.frame.origin.y, UIApplication.shared.keyWindow!.frame.height)
        XCTAssertEqual(notificationView.frame.origin.x, 0)
        XCTAssertEqual(notificationView.frame.origin.x + notificationView.frame.size.width, UIApplication.shared.keyWindow!.frame.width)
        
        let notificationView2 = MDNotificationView(view: UIView(frame: CGRect(x: 50, y: 50, width: 320, height: 50)), position: .bottom)
        notificationView2.show()
        sleep(1)
        notificationView2.hide()
        sleep(1)
    
        XCTAssertEqual(notificationView2.frame.origin.y, UIApplication.shared.keyWindow!.frame.height)
    }
    
}
