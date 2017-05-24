//
//  Test.swift
//  iOS_Show
//
//  Created by dali on 16/11/4.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit



class Test: NSObject {
    var userAction:(() -> Void)? = nil
    
    
    func funcTest(action:@escaping (() -> Void)) {

        let time = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: time) {
            // 3秒后执行
            print("3秒后执行")
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            // 2秒后执行
            print("2秒后执行")
        }
        
        userAction = action
        if userAction !=  nil {
            userAction!()
        }
    }
}
