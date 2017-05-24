//
//  DLNavigationRootVC.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/25.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLNavigationRootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 返回上一页的按钮
        let leftButton = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(DLNavigationRootVC.backClick(_:)))
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        // push到下一页时的返回按钮
        let nextVCBackButton = UIBarButtonItem()
        nextVCBackButton.title = ""
        self.navigationItem.backBarButtonItem = nextVCBackButton
    }
    
    
    
    // 返回按钮触发
    func backClick(_ barButton: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // pushToOne按钮
    @IBAction func pushButton() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "DLNavigationVC_One")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func pushToTwo() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "DLNavigationVC_Two")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
