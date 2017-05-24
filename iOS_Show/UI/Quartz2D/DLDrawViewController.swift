//
//  DLDrawViewController.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLDrawViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        var drawViewRect = self.view.frame
        drawViewRect.origin.y = 64
        let drawView: DLDrawView = DLDrawView(frame: drawViewRect)
        drawView.backgroundColor = UIColor.white
        self.view.addSubview(drawView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
