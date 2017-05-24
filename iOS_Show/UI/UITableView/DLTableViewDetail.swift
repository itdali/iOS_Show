//
//  DLTableViewDetail.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/22.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLTableViewDetail: UIViewController {
    
    var detailTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = detailTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
