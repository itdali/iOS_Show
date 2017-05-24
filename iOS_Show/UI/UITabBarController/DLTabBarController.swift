//
//  DLTabBarController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/22.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        loadAllVC()
    }
    
    func loadAllVC () {
        self.tabBar.backgroundColor = UIColor.white
        

        // 设置tabbar选中时的文字颜色
        self.tabBar.tintColor = UIColor(red: 110/255.0, green: 218/255.0, blue: 236/255.0, alpha: 1.0)
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let item_One = mainStoryBoard.instantiateViewController(withIdentifier: "DLTabBarItem_One")
        // 为了自定义图片的颜色，后面需要加：imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        item_One.tabBarItem.image = UIImage(named: "tabbar_item_01")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        item_One.tabBarItem.selectedImage = UIImage(named: "tabbar_item_selected_01")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        item_One.tabBarItem.title = "One"
        
        let item_Two = mainStoryBoard.instantiateViewController(withIdentifier: "DLTabBarItem_Two")
        item_Two.tabBarItem.image = UIImage(named: "tabbar_item_02")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        item_Two.tabBarItem.selectedImage = UIImage(named: "tabbar_item_selected_02")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        item_Two.tabBarItem.title = "Two"
        self.viewControllers = [item_One, item_Two]
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        DLprint(tabBarController.selectedIndex)
        DLprint(tabBarController.selectedViewController)
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
