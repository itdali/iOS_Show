//
//  DLNavigationController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLNavigationController: UINavigationController, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.delegate = self
    }
    

    // 将要显示时触发
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //DLprint("")
    }
    
    // 已经显示时触发
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //DLprint("")
    }
    
    /*
    func navigationControllerPreferredInterfaceOrientationForPresentation(navigationController: UINavigationController) -> UIInterfaceOrientation {
        <#code#>
    }
    func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        <#code#>
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    }
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
