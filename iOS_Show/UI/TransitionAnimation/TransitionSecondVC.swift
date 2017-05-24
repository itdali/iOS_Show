//
//  TransitionSecondVC.swift
//  iOS_Show
//
//  Created by dali on 16/11/1.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class TransitionSecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.5, alpha: 1.0)
        
        loadAllUI()
    }

    func loadAllUI() {
        let backBtn: UIButton = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        view.addSubview(backBtn)
        
        backBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.top.left.equalTo(view).offset(20)
        }
    }
    func backClick() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
