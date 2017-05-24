//
//  DLScrollVC.swift
//  iOS_Show
//
//  Created by dali on 16/10/8.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLScrollVC: UIViewController {
    
    var scrollView: DLScrollView!
    
    var dataArray: NSMutableArray = ["zip01", "zip01", "zip01", "zip01", "zip01", "zip01", "zip01", "zip01", "zip01", "zip01"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        //loadAllUI()
        
        scrollView = DLScrollView(frame: CGRect(x: 0, y: 70, width: self.view.frame.size.width, height: 300))
        self.view.addSubview(scrollView)
    }
    
    func loadAllUI () {
    }
    
    @IBAction func reloadDataBtn() {
        DLprint(#function)
        DLprint("")
        scrollView.reloadData(data: dataArray)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
