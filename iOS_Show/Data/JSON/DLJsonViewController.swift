//
//  DLJsonViewController.swift
//  iOS_Show
//
//  Created by dali on 19/05/2017.
//  Copyright © 2017 dali. All rights reserved.
//

import UIKit
import SwiftyJSON

class DLJsonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    let jsonStr = "{\"ROOT\":{\"NUM\":13,\"STR\":\"aa021A\",\"ARRAY\":[{\"NAME\":\"abcde\",\"VALUE\":\"4533221\"},{\"NAME\":\"efcdb\",\"VALUE\":\"4566332\"}]}}"
    
    let jsonStr2 = "{\"ResultCode\":1000,\"Message\":\"成功\",\"Data\":{\"shareURL\":\"http://yyh.esstx.cn/yyh/website/index.html?userId=592c1551c4f04d3a\",\"thumbnail\":\"http://yyh.esstx.cn/yyh/img/favicon.png\",\"title\":\"渝优汇首页\"}}"
    
    private var dataArray: Array<[String: Any]> = []
    @IBAction func jsonTest() {
        
        var json: JSON!
        if let dataFromString = jsonStr2.data(using: .utf8, allowLossyConversion: true) {
            json = JSON(data: dataFromString)
        }
        DLprint(json)
        
        DLprint(json["ResultCode"])
        if (json["ROOT"]["ARRAY"].arrayObject != nil) {
            DLprint(json["ROOT"]["ARRAY"].arrayObject)
            /*
            for (key,subJson):(String, JSON) in json["ROOT"]["ARRAY"] {
                DLprint("\(key) - \(subJson)")
            }*/
            self.dataArray = json["ROOT"]["ARRAY"].arrayObject as! Array<[String : Any]>
        } else if (json["ROOT"]["ARRAY"].dictionaryObject != nil) {
            DLprint(json["ROOT"]["ARRAY"].dictionaryObject)
            let dic: [String: Any] = json["ROOT"]["ARRAY"].dictionaryObject!
            self.dataArray.append(dic)
        } else {
            DLprint(json["ROOT"]["ARRAY"].error)
        }
        
        
        
        /*
        // String => JSON
        let json = JSON(jsonStr)
        DLprint(json)
        
        // JSON => String
        let ROOT = json["ROOT"]
        let NUM = ROOT["NUM"]
        DLprint(NUM)
        
        // type check
        if ROOT["NUM"].isInt {
            DLprint("NUM is Int")
        } else {
            DLprint("NUM is not Int")
        }
        
        if json["ROOT"]["ARRAY"].isArray {
            DLprint("ARRAY is Array")
        } else {
            DLprint("ARRAY is not Array")
        }
        
        if json["ROOT"]["ARRAY"].isNSArray {
            DLprint("ARRAY is NSArray")
        } else {
            DLprint("ARRAY is not NSArray")
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
