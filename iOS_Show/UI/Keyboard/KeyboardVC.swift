//
//  KeyboardVC.swift
//  iOS_Show
//
//  Created by dali on 2016/11/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class KeyboardVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}
