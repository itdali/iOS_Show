//
//  RootVC.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/18.
//  Copyright © 2016年 dali. All rights reserved.
//
// APP打开的根页，其他页面都通过这个页面跳转过去

import UIKit

class RootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // push到下一页时的返回按钮
        let nextVCBackButton = UIBarButtonItem()
        nextVCBackButton.title = ""
        self.navigationItem.backBarButtonItem = nextVCBackButton
        
        DLprint("boxDocPath==\(boxDocPath)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
