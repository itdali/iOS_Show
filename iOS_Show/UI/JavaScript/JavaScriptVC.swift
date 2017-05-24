//
//  JavaScriptVC.swift
//  iOS_Show
//
//  Created by dali on 2016/11/21.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import JavaScriptCore

class JavaScriptVC: UIViewController {
    
    var jsContext: JSContext = JSContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        loadAllUI()
        
        
    }
    
    func loadAllUI() {
        // backBtn
        let backBtn: UIButton = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        view.addSubview(backBtn)
        
        let jsBtn: UIButton = UIButton()
        jsBtn.setTitle("JS_Btn", for: .normal)
        jsBtn.setTitleColor(UIColor.blue, for: .normal)
        jsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        jsBtn.addTarget(self, action: #selector(javaScriptTest), for: UIControlEvents.touchUpInside)
        view.addSubview(jsBtn)
        
        backBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(view).offset(30)
            make.left.equalTo(view).offset(20)
            make.size.equalTo(CGSize(width: 50, height: 20))
        }
        
        jsBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(backBtn.snp.bottom).offset(10)
            make.left.equalTo(backBtn)
            make.size.equalTo(CGSize(width: 100, height: 20))
        }
    }
    func backClick() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Swift 调用 JavaScript
    func javaScriptTest() {
        
        // run empty func
        let path_A = Bundle.main.path(forResource: "testA", ofType: "js")
        let url_A: URL = URL(fileURLWithPath: ((path_A != nil) ? path_A! : ""))
        var jsData_A: Data = Data()
        do {
            jsData_A = try Data.init(contentsOf: url_A)
        } catch {
            DLprint("jsData_A init failure")
        }
        let jsString_A = String.init(data: jsData_A, encoding: String.Encoding.utf8)
        jsContext.evaluateScript(jsString_A)
        
        
        
        // JS func and parameter
        jsContext.evaluateScript("var num1 = 1; var num2 = 2;")
        jsContext.evaluateScript("function sum(a,b){return a+b;};")
        let result = jsContext.evaluateScript("sum(num1,num2);").toInt32()
        DLprint(result)
        
        // run JS func by subscript
        let jsFunc = jsContext.objectForKeyedSubscript("sum")
        let result2 = jsFunc?.call(withArguments: [3,5]).toInt32()
        DLprint(result2)
        
        
        
    
    }
    
    deinit {
        DLprint("==== deinit ====")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
