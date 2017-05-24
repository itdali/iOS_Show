//
//  DLBarVC.swift
//  UIShow_Swift
//
//  Created by dali on 16/8/30.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLBarVC: UIViewController, DLBarViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let barView: DLBarView = DLBarView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 80))
        barView.delegate = self
        self.view.addSubview(barView)
        
        barView.barArray = [
            ["a", "aaaaa"],
            ["b", "bbbbb"],
            ["c", "ccccc"],
            ["d", "ddddd"]]

    }
    
    
    
    
    //MARK: DLBarView Delegate
    func barView(barView: UIView, barIndex: Int) {
        DLprint(barIndex)
    }

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
