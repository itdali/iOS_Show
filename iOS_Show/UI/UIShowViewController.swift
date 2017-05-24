//
//  UIShowViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class UIShowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // push到下一页时的返回按钮
        let nextVCBackButton = UIBarButtonItem()
        nextVCBackButton.title = ""
        self.navigationItem.backBarButtonItem = nextVCBackButton
        
        
    }
    
    @IBAction func DLWKWebViewClick() {
        self.navigationController?.pushViewController(DLWKWebViewVC(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
