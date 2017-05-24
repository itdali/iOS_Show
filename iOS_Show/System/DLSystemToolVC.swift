//
//  DLSystemToolVC.swift
//  iOS_Show
//
//  Created by dali on 2016/11/21.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit
import WebKit

class DLSystemToolVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        loadAllUI()
    }
    
    func loadAllUI() {
        
        // get iOS version
        let iOS_Version_Btn: UIButton = UIButton()
        iOS_Version_Btn.setTitle("iOS_Version", for: .normal)
        iOS_Version_Btn.setTitleColor(UIColor.blue, for: .normal)
        iOS_Version_Btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        iOS_Version_Btn.addTarget(self, action: #selector(iOSVersionClick), for: UIControlEvents.touchUpInside)
        view.addSubview(iOS_Version_Btn)
        
        // clean WebKit cache
        let cleanWKCacheBtn: UIButton = UIButton()
        cleanWKCacheBtn.setTitle("clean Wk cache", for: .normal)
        cleanWKCacheBtn.setTitleColor(UIColor.orange, for: .normal)
        cleanWKCacheBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cleanWKCacheBtn.addTarget(self, action: #selector(cleanWebViewCookies), for: UIControlEvents.touchUpInside)
        view.addSubview(cleanWKCacheBtn)
        
        
        iOS_Version_Btn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(view).offset(64+50)
            make.left.equalTo(view).offset(30)
            make.size.equalTo(CGSize(width: 150, height: 20))
        }
        cleanWKCacheBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(iOS_Version_Btn.snp.bottom).offset(20)
            make.left.equalTo(iOS_Version_Btn)
            make.size.equalTo(iOS_Version_Btn)
        }
    }
    
    func backClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func iOSVersionClick() {
        // 获取系统版本号
        let iOSVersion = UIDevice.current.systemVersion
        DLprint(iOSVersion)
        
        // 区分版本号做操作
        if #available(iOS 10.0, *) {
            DLprint("iOS 10.0")
        } else {
            if #available(iOS 9.0, *) {
                DLprint("iOS 9.0")
            } else {
                DLprint("older than iOS 9.0")
            }
        }
    }
    
    /// 清空WKWebview的缓存
    func cleanWebViewCookies () {
        if #available(iOS 9.0, *) {
            let webDataType = WKWebsiteDataStore.allWebsiteDataTypes()
            let dateFrom = Date(timeIntervalSince1970: 0)
            WKWebsiteDataStore.default().removeData(ofTypes: webDataType, modifiedSince: dateFrom)
            { () -> Void in
                DLprint("清空WKWebview的缓存  iOS 9.0")
            }
        } else {
            // Fallback on earlier versions
            let cookiesPath = boxLibPath.appendingPathComponent("Cookies")
            let webkitPath = boxLibPath.appendingPathComponent("WebKit")
            let CachesPath = boxLibPath.appendingPathComponent("Caches")
            do {
                try FileManager.default.removeItem(atPath: cookiesPath)
                DLprint("清理成功cookiesPath")
            }
            catch {
                DLprint("清理catch cookiesPath")
            }
            do {
                try FileManager.default.removeItem(atPath: webkitPath)
                DLprint("清理成功 webkitPath")
            }
            catch {
                DLprint("清理catch webkitPath")
            }
            do {
                try FileManager.default.removeItem(atPath: CachesPath)
                DLprint("清理成功 CachesPath")
            }
            catch {
                DLprint("清理catch CachesPath")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
