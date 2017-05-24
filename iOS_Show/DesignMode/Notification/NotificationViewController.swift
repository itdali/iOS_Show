//
//  NotificationViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/8/3.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    
    @IBOutlet weak var showLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationViewController.notificationAClick), name: NSNotification.Name(rawValue: "notificationA"), object: nil)
    }
    
    
    @IBAction func postNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "notificationA"), object: nil)
    }
    
    func notificationAClick() {
        DLprint("触发了 notificationA")
        showLabel.text = "触发了 notificationA"
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        DLprint("")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "notificationA"), object: nil)
    }
}
