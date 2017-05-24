//
//  AutoLayoutVC.swift
//  iOS_Show
//
//  Created by dali on 16/10/30.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class AutoLayoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.orange
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
