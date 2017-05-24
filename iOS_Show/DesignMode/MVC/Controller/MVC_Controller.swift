//
//  MVC_Controller.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class MVC_Controller: UIViewController {
    
    var model: MVC_Model!
    var mvcView: MVC_View!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataSource()
        
        addView()
    }

    func loadDataSource() {
        let dataSource:NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "MVC_Data", ofType: "plist")!)!
        model = MVC_Model()
        model.mj_setKeyValues(dataSource)
        DLprint(dataSource)
    }
    
    func addView() {
        mvcView = MVC_View(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 20*2, height: 200))
        
        
        mvcView.usernameLabel.text = model.username
        mvcView.passwordLabel.text = model.password
        mvcView.phonenumLabel.text = model.phonenum
        mvcView.emailLabel.text = model.email
        
        self.view.addSubview(mvcView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
