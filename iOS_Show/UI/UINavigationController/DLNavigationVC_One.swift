//
//  DLNavigationVC_One.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLNavigationVC_One: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func hiddenNavigationBar(_ sender: UISwitch) {
        self.navigationController?.isNavigationBarHidden = sender.isOn
    }
    
    @IBAction func makeNavClear(_ sender: UISwitch) {
        
        //给navigationBar设置一个空的背景图片即可实现透明，而且标题按钮都在
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // 去掉黑色的横线
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        DLprint(" ===== deinit ===== ")
    }


}
