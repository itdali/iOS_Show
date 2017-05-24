//
//  DelegateViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DelegateViewController: UIViewController, DLViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let delegateView: DelegateView = DelegateView(frame: CGRect(x: 20, y: 100, width: 200, height: 100))
        delegateView.delegate = self
        self.view.addSubview(delegateView)
    }
    
    //MARK: DelegateView delegate
    func delegateView(_ view: UIView, button: UIButton) {
        DLprint("触发了 DelegateView 里的代理方法")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
