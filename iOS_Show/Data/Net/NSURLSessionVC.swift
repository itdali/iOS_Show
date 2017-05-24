//
//  NSURLSessionVC.swift
//  iOS_Show
//
//  Created by dali on 16/10/30.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import SnapKit

class NSURLSessionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        loadAllUI()
    }

    func loadAllUI() {
        let backBtn = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.addTarget(self, action: #selector(NSURLSessionVC.backBtnClick), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let getBtn = UIButton()
        getBtn.setTitle("GET", for: .normal)
        getBtn.setTitleColor(UIColor.blue, for: .normal)
        getBtn.addTarget(self, action: #selector(NSURLSessionVC.getBtnClick), for: .touchUpInside)
        self.view.addSubview(getBtn)
        
        //backBtn.backgroundColor = UIColor.orange
        getBtn.backgroundColor = UIColor.orange
        
        let padding = 10
        
        backBtn.snp.makeConstraints{(make) -> Void in
            make.top.greaterThanOrEqualTo(view).offset(20)
            make.left.equalTo(view).offset(padding)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        getBtn.snp.makeConstraints{(make)-> Void in
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.top.equalTo(backBtn.snp.bottom).offset(padding*2)
            make.left.equalTo(view.snp.left).offset(padding)
        }
    }
    func backBtnClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- NSURLSession
    func getBtnClick() {
        let url: URL = URL(string: "http://120.25.226.186:32812/login?username=520&pwd=520&type=JSON")!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url){(data:Data?, response:URLResponse?,error:Error?) -> Void in
            
            
            let dataStr = String.init(data: data!, encoding: String.Encoding.utf8)
            DLprint(dataStr)
            DLprint(Thread.current)
        }
        dataTask.resume()
    }
    
    func postBtnClick() {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
