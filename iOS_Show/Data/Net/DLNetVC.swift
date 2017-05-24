//
//  DLNetVC.swift
//  iOS_Show
//
//  Created by dali on 16/10/30.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLNetVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func URLSession() {
        let urlSessionVC = NSURLSessionVC()
        self.present(urlSessionVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
