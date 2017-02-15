//
//  MDNotificationLayoutView.swift
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

/// The wrapper class for the view layouts that ship with MDNotificationView.
/// **Do not instantiate directly.**
public class MDNotificationLayoutView : UIView {
    
    /// The view that will be added as a subview to this view.
    var view: UIView!

    /// Loads the nib with the given name and adds its view as a subview to self.
    ///
    /// - parameter named:      The name of the nib file to load.
    func addNib(named nibName: String) {
        let bundle = Bundle(for: type(of: self))
        if let bundleUrl = bundle.url(forResource: "MDNotificationView", withExtension: "bundle"),
            let bundle = Bundle(url: bundleUrl) {
            let nib = UINib(nibName: nibName, bundle: bundle)
            let views = nib.instantiate(withOwner: self, options: nil)
            
            if 0 < views.count,
                let view = views[0] as? UIView {
                
                view.frame = bounds
                view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
                self.addSubview(view)
            }
        }
    }

}
