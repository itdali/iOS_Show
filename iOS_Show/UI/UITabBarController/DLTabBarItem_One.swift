//
//  DLTabBarItem_One.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/22.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLTabBarItem_One: UIViewController {
    
    let num = "3"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarItem.badgeValue = num
    }
    
    
    @IBAction func switchButtonClick(_ sender: UISwitch) {
        self.tabBarItem.badgeValue = sender.isOn ? num : nil
    }
    
    @IBAction func hiddenTabBar(_ sender: UISwitch) {
        self.tabBarController!.tabBar.isHidden = sender.isOn
    }
    
    
    @IBAction func backButtonClick() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
