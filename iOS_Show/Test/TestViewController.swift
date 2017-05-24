//
//  TestViewController.swift
//  iOS_Show
//
//  Created by dali on 16/10/16.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import Alamofire
import JavaScriptCore

class TestViewController: UIViewController {

    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllUI()
        createSomething()
    }
    
    func loadAllUI() {
        let funcBtn: UIButton = UIButton()
        funcBtn.setTitle("方法调用测试", for: .normal)
        funcBtn.setTitleColor(UIColor.blue, for: .normal)
        funcBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        funcBtn.addTarget(self, action: #selector(testFuncClick), for: UIControlEvents.touchUpInside)
        view.addSubview(funcBtn)
        
        let webBtn: UIButton = UIButton()
        webBtn.setTitle("WKWebTest", for: .normal)
        webBtn.setTitleColor(UIColor.blue, for: .normal)
        webBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        webBtn.addTarget(self, action: #selector(testWebClick), for: UIControlEvents.touchUpInside)
        view.addSubview(webBtn)
        
        let lifecycleBtn: UIButton = UIButton()
        lifecycleBtn.setTitle("Lifecycle", for: .normal)
        lifecycleBtn.setTitleColor(UIColor.blue, for: .normal)
        lifecycleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        lifecycleBtn.addTarget(self, action: #selector(lifecycleClick), for: UIControlEvents.touchUpInside)
        view.addSubview(lifecycleBtn)
        
        let timerFireBtn: UIButton = UIButton()
        timerFireBtn.setTitle("timerFire", for: .normal)
        timerFireBtn.setTitleColor(UIColor.blue, for: .normal)
        timerFireBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        timerFireBtn.addTarget(self, action: #selector(timerFireClick), for: UIControlEvents.touchUpInside)
        view.addSubview(timerFireBtn)
        
        let timerInvalidateBtn: UIButton = UIButton()
        timerInvalidateBtn.setTitle("timerInvalidate", for: .normal)
        timerInvalidateBtn.setTitleColor(UIColor.blue, for: .normal)
        timerInvalidateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        timerInvalidateBtn.addTarget(self, action: #selector(timerInvalidateClick), for: UIControlEvents.touchUpInside)
        view.addSubview(timerInvalidateBtn)
        
        let alamofireBtn: UIButton = UIButton()
        alamofireBtn.setTitle("Alamofire", for: .normal)
        alamofireBtn.setTitleColor(UIColor.blue, for: .normal)
        alamofireBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        alamofireBtn.addTarget(self, action: #selector(alamofireClick), for: UIControlEvents.touchUpInside)
        view.addSubview(alamofireBtn)
        
        let jsTestBtn: UIButton = UIButton()
        jsTestBtn.setTitle("JavaScript", for: .normal)
        jsTestBtn.setTitleColor(UIColor.blue, for: .normal)
        jsTestBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        jsTestBtn.addTarget(self, action: #selector(jsTestClick), for: UIControlEvents.touchUpInside)
        view.addSubview(jsTestBtn)
        
        let dateBtn: UIButton = UIButton()
        dateBtn.setTitle("date test", for: .normal)
        dateBtn.setTitleColor(UIColor.blue, for: .normal)
        dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        dateBtn.addTarget(self, action: #selector(dateTestClick), for: UIControlEvents.touchUpInside)
        view.addSubview(dateBtn)
        
        let getAppNameBtn: UIButton = UIButton()
        getAppNameBtn.setTitle("getAppNameBtn", for: .normal)
        getAppNameBtn.setTitleColor(UIColor.blue, for: .normal)
        getAppNameBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        getAppNameBtn.addTarget(self, action: #selector(getAppNameClick), for: UIControlEvents.touchUpInside)
        view.addSubview(getAppNameBtn)
        
        let WKBrowserBtn: UIButton = UIButton()
        WKBrowserBtn.setTitle("WKBrowserBtn", for: .normal)
        WKBrowserBtn.setTitleColor(UIColor.blue, for: .normal)
        WKBrowserBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        WKBrowserBtn.addTarget(self, action: #selector(WKBrowserClick), for: UIControlEvents.touchUpInside)
        view.addSubview(WKBrowserBtn)
        
        
        let mkdirBtn: UIButton = UIButton()
        mkdirBtn.setTitle("mkdirBtn", for: .normal)
        mkdirBtn.setTitleColor(UIColor.blue, for: .normal)
        mkdirBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mkdirBtn.addTarget(self, action: #selector(mkdirClick), for: UIControlEvents.touchUpInside)
        view.addSubview(mkdirBtn)
        
        funcBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(CGSize(width: 120, height: 20))
            make.top.equalTo(view).offset(70)
            make.left.equalTo(view).offset(20)
        }
        webBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(funcBtn)
            make.centerX.equalTo(funcBtn)
            make.top.equalTo(funcBtn.snp.bottom).offset(10)
        }
        lifecycleBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(webBtn)
            make.centerX.equalTo(webBtn)
            make.top.equalTo(webBtn.snp.bottom).offset(10)
        }
        timerFireBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(lifecycleBtn)
            make.centerX.equalTo(lifecycleBtn)
            make.top.equalTo(lifecycleBtn.snp.bottom).offset(10)
        }
        timerInvalidateBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(timerFireBtn)
            make.centerX.equalTo(timerFireBtn)
            make.top.equalTo(timerFireBtn.snp.bottom).offset(10)
        }
        alamofireBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(timerInvalidateBtn)
            make.centerX.equalTo(timerInvalidateBtn)
            make.top.equalTo(timerInvalidateBtn.snp.bottom).offset(10)
        }
        jsTestBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(alamofireBtn)
            make.centerX.equalTo(alamofireBtn)
            make.top.equalTo(alamofireBtn.snp.bottom).offset(10)
        }
        dateBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(jsTestBtn)
            make.centerX.equalTo(jsTestBtn)
            make.top.equalTo(jsTestBtn.snp.bottom).offset(20)
        }
        getAppNameBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(dateBtn)
            make.centerX.equalTo(dateBtn)
            make.top.equalTo(dateBtn.snp.bottom).offset(20)
        }
        WKBrowserBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(getAppNameBtn)
            make.centerX.equalTo(getAppNameBtn)
            make.top.equalTo(getAppNameBtn.snp.bottom).offset(20)
        }
        mkdirBtn.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(WKBrowserBtn)
            make.centerX.equalTo(WKBrowserBtn)
            make.top.equalTo(WKBrowserBtn.snp.bottom).offset(20)
        }
        
    }
    
    func createSomething() {
        //timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(timerClick), userInfo: nil, repeats: true)
    }
    
    
    //MARK:- 按钮触发
    // 方法调用测试
    func testFuncClick() {
        Test().funcTest{() -> Void in
            DLprint("123")
        }
    }
    
    // WKWebTest
    func testWebClick() {
        let webVC = TestWKWebVC()
        webVC.modalPresentationStyle = .overFullScreen
        present(webVC, animated: true, completion: nil)
    }
    
    // lifecycle
    func lifecycleClick() {
        let lifecycleVC = TestLifecycleVC()
        present(lifecycleVC, animated: true, completion: nil)
    }
    
    // timerFireClick
    func timerFireClick() {
        timer.fire()
    }
    
    // timerInvalidateClick
    func timerInvalidateClick() {
        timer.invalidate()
    }
    
    // alamofireClick
    func alamofireClick() {
    }
    
    // 测试日期比较
    func festivalShow() {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: nowDate)
        DLprint(today)
        if today > "2016-10-14" && today < "2016-10-17"{
            DLprint("today > 2016-10-14")
        }
    }
    
    //MARK:- 其他触发
    // timerClick
    func timerClick() {
        print(#function)
    }
    
    
    func jsTestClick() {
        let context: JSContext = JSContext()
        let value = context.evaluateScript("1+3")
        DLprint(value)
    }
    
    
    func dateTestClick() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr = dateFormatter.string(from: currentDate)
        DLprint(dateStr)
        
        let calendar = Calendar.current
        DLprint(calendar)
        var dateComponent = DateComponents()
        dateComponent.day = 1
        DLprint(currentDate)
        let calculatedDate = calendar.date(byAdding: dateComponent, to: currentDate)
        
        DLprint(calculatedDate)
    }
    
    func getAppNameClick() {
        DLprint("")
    }
    
    func WKBrowserClick() {
        self.navigationController?.pushViewController(WKRootViewController(), animated: true)
    }
    
    /// 创建文件夹
    func mkdirClick() {
        /*
        let fileManager = FileManager.default
        let dirPath = boxDocPath.appendingPathComponent("Attachment")
        do {
            try fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
        }
        catch {
            DLprint("创建文件夹失败")
            return
        }
        DLprint("创建文件夹成功")
 */
        
        
        let urlStr = "http://www.itdali.com/wp-content/uploads/2016/08/UITableView14.png"
        let filePath = boxDocPath.appendingPathComponent("Attachment/UITableView14.png")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("Attachment/UITableView14.png")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        // 下载附件
        Alamofire.download(urlStr, to: destination)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
            if let data = response.result.value {
                DLprint("下载成功")
            }
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
