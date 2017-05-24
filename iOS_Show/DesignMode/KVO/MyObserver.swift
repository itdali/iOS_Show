//
//  MyObserver.swift
//  iOS_Show
//
//  Created by dali on 2017/3/11.
//  Copyright © 2017年 dali. All rights reserved.
//

import UIKit

class MyObjectToObserve: NSObject {
    dynamic var myDate = NSData()
    func updateDate() {
        myDate = NSData()
    }
}

private var myContext = 0

class MyObserver: NSObject {
    var objectToObserve = MyObjectToObserve()
    override init() {
        super.init()
        objectToObserve.addObserver(self, forKeyPath: "myDate", options: .new, context: &myContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myContext {
            if let newValue = change?[.newKey] {
                DLprint("Data changed: \(newValue)")
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        objectToObserve.removeObserver(self, forKeyPath: "myDate", context: &myContext)
    }

}
