//
//  MDNotificationExpandedImageLayoutView.swift
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

public class MDNotificationExpandedImageLayoutView : MDNotificationLayoutView {

    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: 100))

        self.backgroundColor = UIColor.clear
        super.addNib(named: "MDNotificationExpandedImageLayoutView")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clear
        super.addNib(named: "MDNotificationExpandedImageLayoutView")
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        self.imageView.layer.masksToBounds = true
    }

}