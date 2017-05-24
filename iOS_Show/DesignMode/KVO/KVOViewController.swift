//
//  KVOViewController.swift
//  iOS_Show
//
//  Created by dali on 2017/3/11.
//  Copyright © 2017年 dali. All rights reserved.
//

import UIKit


class KVOViewController: UIViewController {
    
    let myObserver = MyObserver()
    
    
    var attr: Int = 0 {
        willSet(newValue) {
            DLprint("newValue = \(newValue)")
        }
        didSet {
            DLprint("newValue - oldValue = \(attr - oldValue)")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateDate() {
        myObserver.objectToObserve.updateDate()
    }
    
    @IBAction func attrObserveBtn() {
        attr += 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
